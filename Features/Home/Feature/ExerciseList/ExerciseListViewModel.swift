//
//  ExerciseListViewModel.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import SwiftUI

@Observable
public final class ExerciseListViewModel {

    // MARK: - Properties

    /// 운동 목록
    public var exercises: [String] = []

    /// 로딩 상태
    public var isLoading: Bool = false

    /// 에러 메시지
    public var errorMessage: String?

    private let exerciseListUseCase: ExerciseListUseCase
    private let cacheManager: ExerciseCacheManager

    // MARK: - Initialization

    public init(
        exerciseListUseCase: ExerciseListUseCase,
        cacheManager: ExerciseCacheManager = .shared
    ) {
        self.exerciseListUseCase = exerciseListUseCase
        self.cacheManager = cacheManager

        Task {
            await loadExercises()
        }
    }

    // MARK: - Business Logic

    /// 운동 목록 로드 (SWR 전략)
    @MainActor
    public func loadExercises(forceRefresh: Bool = false) async {
        errorMessage = nil

        // 1. 강제 새로고침이 아니면 캐시 먼저 로드
        if !forceRefresh, let cachedExercises = cacheManager.load() {
            exercises = cachedExercises
            print("⚡️ 캐시 데이터 즉시 표시")
        }

        // 2. 백그라운드에서 API 호출 (SWR 전략)
        isLoading = true

        do {
            if let model = try await exerciseListUseCase.execute() {
                let freshExercises = model.exerciseList

                // 3. 데이터가 변경되었는지 확인
                if freshExercises != exercises {
                    exercises = freshExercises
                    cacheManager.save(freshExercises)
                    print("🔄 API 데이터로 업데이트 완료")
                } else {
                    print("✅ 데이터 변경 없음")
                }
            } else {
                // API 응답이 없을 때
                if exercises.isEmpty {
                    errorMessage = "운동 목록을 불러올 수 없습니다"
                }
            }
        } catch {
            print("❌ API 호출 실패: \(error)")

            // 에러 시 캐시 데이터 유지
            if exercises.isEmpty {
                errorMessage = "네트워크 오류가 발생했습니다"
            } else {
                print("💡 캐시 데이터 유지")
            }
        }

        isLoading = false
    }

    /// 캐시 삭제
    public func clearCache() {
        cacheManager.clear()
    }
}
