//
//  ExerciseListView.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import SwiftUI

struct ExerciseListView: View {

    let onDismissAll: () -> Void

    // 운동 목록 데이터
    private let exercises = [
        "푸시업", "턱걸이", "런지", "스쿼트", "플랭크",
        "버피", "데드리프트", "벤치프레스",
        "사이드 레터럴 레이즈", "바이셉 컬", "크런치", "레그레이즈"
    ]

    // 2열 그리드 레이아웃 설정
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    // Sheet 표시 상태
    @State private var selectedExercise: String?
    @State private var showingExerciseSheet = false

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(exercises, id: \.self) { exercise in
                    ExerciseCell(title: exercise)
                        .onTapGesture {
                            selectedExercise = exercise
                            showingExerciseSheet = true
                        }
                }
            }
            .padding()
        }
        .navigationTitle("운동 선택")
        .navigationBarTitleDisplayMode(.inline)
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

// MARK: - Preview

#Preview {
    NavigationStack {
        ExerciseListView(onDismissAll: {})
    }
}
