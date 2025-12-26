//
//  WorkoutHistoryView.swift
//  HomeFeature
//
//  Created by taeuk on 12/27/25.
//

import SwiftUI
import SwiftData
import TestShared

struct WorkoutHistoryView: View {
    let selectedDate: Date
    @Environment(\.modelContext) private var modelContext
    @Query private var allWorkouts: [WorkoutRecord]

    // 선택된 날짜의 운동 기록만 필터링
    private var workoutsForSelectedDate: [WorkoutRecord] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        return allWorkouts.filter { workout in
            workout.date >= startOfDay && workout.date < endOfDay
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        return formatter
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 날짜 헤더
                VStack(spacing: 8) {
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.title2)
                        .fontWeight(.bold)

                    if !workoutsForSelectedDate.isEmpty {
                        Text("총 \(workoutsForSelectedDate.count)개의 운동")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 20)

                if workoutsForSelectedDate.isEmpty {
                    // 운동 기록이 없을 때
                    VStack(spacing: 16) {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 60))
                            .foregroundStyle(.gray)

                        Text("이 날의 운동 기록이 없습니다")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text("운동을 완료하면 여기에 기록됩니다")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 80)
                } else {
                    // 운동 기록 리스트
                    VStack(spacing: 16) {
                        ForEach(workoutsForSelectedDate.sorted(by: { $0.date > $1.date })) { workout in
                            WorkoutRecordCard(workout: workout)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
        }
        .navigationTitle("운동 기록")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Workout Record Card

struct WorkoutRecordCard: View {
    let workout: WorkoutRecord

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 운동명과 시간
            HStack {
                Text(workout.exerciseName)
                    .font(.headline)

                Spacer()

                Text(timeFormatter.string(from: workout.date))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // 세트와 횟수
            HStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("세트")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(workout.sets)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("횟수")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(workout.reps)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("총 운동량")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(workout.sets * workout.reps)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }

            // 메모 (있을 경우)
            if let notes = workout.notes, !notes.isEmpty {
                Divider()
                Text(notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview("With Workouts") {
    NavigationStack {
        WorkoutHistoryView(selectedDate: Date())
            .modelContainer(for: WorkoutRecord.self, inMemory: true)
    }
}

#Preview("Empty") {
    NavigationStack {
        WorkoutHistoryView(selectedDate: Date())
            .modelContainer(for: WorkoutRecord.self, inMemory: true)
    }
}
