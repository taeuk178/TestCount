//
//  ExerciseResultView.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import SwiftUI

// MARK: - Exercise Result View

struct ExerciseResultView: View {

    let exerciseName: String
    let sets: Int
    let reps: Int
    let onDismiss: () -> Void
    let onDismissAll: () -> Void

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {

                Spacer()

                // 축하 메시지
                VStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.green)

                    Text("운동 완료!")
                        .font(.system(size: 32, weight: .bold))

                    Text("수고하셨습니다")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                // 운동 결과 요약
                VStack(spacing: 20) {
                    ResultRow(title: "운동", value: exerciseName)
                    ResultRow(title: "세트", value: "\(sets) 세트")
                    ResultRow(title: "횟수", value: "\(reps) 회")
                    ResultRow(title: "총 운동량", value: "\(sets * reps) 회")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal)

                Spacer()

                // 홈으로 돌아가기 버튼
                Button {
                    dismiss() // 결과 화면 닫기
                    onDismiss() // ExerciseDetailView 닫기
                    onDismissAll() // 모든 navigation 닫고 홈으로
                } label: {
                    Text("홈으로 돌아가기")
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
            .navigationTitle("운동 결과")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        dismiss()
                        onDismiss()
                    }
                }
            }
        }
        .presentationDetents([.large])
    }
}

// MARK: - Result Row

struct ResultRow: View {

    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
}

#Preview("Exercise Result") {
    ExerciseResultView(
        exerciseName: "푸시업",
        sets: 3,
        reps: 10,
        onDismiss: {},
        onDismissAll: {}
    )
}
