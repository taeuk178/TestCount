//
//  ExerciseCacheManager.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation

public final class ExerciseCacheManager {

    public static let shared = ExerciseCacheManager()

    private let cacheKey = "cached_exercise_list"

    private init() {}

    // MARK: - Public Methods

    /// 운동 목록 저장
    public func save(_ exerciseList: [String]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(exerciseList) {
            UserDefaults.standard.set(data, forKey: cacheKey)
            print("💾 캐시 저장 완료: \(exerciseList.count)개 운동")
        }
    }

    /// 운동 목록 로드
    public func load() -> [String]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else {
            print("📭 캐시 없음")
            return nil
        }

        let decoder = JSONDecoder()
        if let exerciseList = try? decoder.decode([String].self, from: data) {
            print("📦 캐시 로드 완료: \(exerciseList.count)개 운동")
            return exerciseList
        }

        return nil
    }

    /// 캐시 삭제
    public func clear() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
        print("🗑️ 캐시 삭제 완료")
    }

    /// 캐시 존재 여부
    public func exists() -> Bool {
        return UserDefaults.standard.data(forKey: cacheKey) != nil
    }
}
