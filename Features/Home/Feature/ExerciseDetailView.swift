//
//  ExerciseDetailView.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import SwiftUI

// MARK: - Exercise Detail View

struct ExerciseDetailView: View {

    let exerciseName: String
    let onDismissAll: () -> Void
    @Environment(\.dismiss) var dismiss

    @State private var sets: Int = 3
    @State private var reps: Int = 10
    @State private var isCompleted: Bool = false
    @State private var showingResultSheet: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {

                // 운동 이름
                Text(exerciseName)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 40)

                Spacer()

                // 세트/횟수 입력
                VStack(spacing: 24) {

                    // 세트 수
                    HStack {
                        Text("세트")
                            .font(.headline)
                            .frame(width: 80, alignment: .leading)

                        Stepper("\(sets) 세트", value: $sets, in: 1...10)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    // 횟수
                    HStack {
                        Text("횟수")
                            .font(.headline)
                            .frame(width: 80, alignment: .leading)

                        Stepper("\(reps) 회", value: $reps, in: 1...50)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()

                // 완료 버튼
                Button {
                    isCompleted = true
                    showingResultSheet = true
                } label: {
                    Text("운동 완료")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .navigationTitle("운동하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingResultSheet) {
                ExerciseResultView(
                    exerciseName: exerciseName,
                    sets: sets,
                    reps: reps,
                    onDismiss: {
                        dismiss()
                    },
                    onDismissAll: onDismissAll
                )
            }
        }
        .presentationDetents([.large])
    }
}

// MARK: - Preview

#Preview("Exercise Detail") {
    ExerciseDetailView(exerciseName: "푸시업", onDismissAll: {})
}

