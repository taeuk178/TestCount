//
//  ExerciseListView.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import SwiftUI
import NetworkKit

struct ExerciseListView: View {

    let onDismissAll: () -> Void

    // ViewModel
    @State private var viewModel: ExerciseListViewModel

    // 2열 그리드 레이아웃 설정
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    // Sheet 표시 상태
    @State private var selectedExercise: String?
    @State private var showingExerciseSheet = false

    init(onDismissAll: @escaping () -> Void) {
        self.onDismissAll = onDismissAll

        // ViewModel 초기화
        let provider = CustomProvider<ExerciseListAPI>()
        let useCase = ExerciseListUseCaseImpl(provider: provider)
        self._viewModel = State(initialValue: ExerciseListViewModel(exerciseListUseCase: useCase))
    }

    var body: some View {
        ScrollView {
            if viewModel.isLoading && viewModel.exercises.isEmpty {
                // 첫 로딩 시에만 표시
                ProgressView("운동 목록 불러오는 중...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage, viewModel.exercises.isEmpty {
                // 에러 시 (캐시 없을 때만)
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(.orange)

                    Text(errorMessage)
                        .foregroundStyle(.secondary)

                    Button("다시 시도") {
                        Task {
                            await viewModel.loadExercises(forceRefresh: true)
                        }
                    }
                }
                .padding()
            } else {
                // 운동 목록 표시
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.exercises, id: \.self) { exercise in
                        ExerciseCell(title: exercise)
                            .onTapGesture {
                                selectedExercise = exercise
                                showingExerciseSheet = true
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("운동 선택")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            // Pull-to-refresh
            await viewModel.loadExercises(forceRefresh: true)
        }
        .sheet(isPresented: $showingExerciseSheet) {
            if let exercise = selectedExercise {
                ExerciseDetailView(
                    exerciseName: exercise,
                    onDismissAll: onDismissAll
                )
            }
        }
    }
}

// MARK: - Exercise Cell

struct ExerciseCell: View {

    let title: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)

            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
        }
        .frame(height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
