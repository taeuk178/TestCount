
import SwiftUI
import SwiftData

import HomeInterface
import TestShared

enum HomeNavigationDestination: Hashable {
    case exerciseList
    case workoutHistory(Date)
}

public struct HomeView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WorkoutRecord.date, order: .reverse) private var workouts: [WorkoutRecord]

    @State private var navigationPath: [HomeNavigationDestination] = []

    // SwiftData에서 운동한 날짜들 가져오기
    private var exerciseDates: Set<Date> {
        let calendar = Calendar.current
        return Set(workouts.map { calendar.startOfDay(for: $0.date) })
    }

    public init() { }

    // 샘플 운동 데이터 추가
    private func addSampleWorkouts() {
        let calendar = Calendar.current
        let today = Date()

        // 오늘
        let workout1 = WorkoutRecord(
            date: today,
            exerciseName: "푸시업",
            sets: 3,
            reps: 10
        )

        // 어제
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
            let workout2 = WorkoutRecord(
                date: yesterday,
                exerciseName: "스쿼트",
                sets: 4,
                reps: 12
            )
            modelContext.insert(workout2)
        }

        // 3일 전
        if let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: today) {
            let workout3 = WorkoutRecord(
                date: threeDaysAgo,
                exerciseName: "플랭크",
                sets: 3,
                reps: 1
            )
            modelContext.insert(workout3)
        }

        // 일주일 전
        if let weekAgo = calendar.date(byAdding: .day, value: -7, to: today) {
            let workout4 = WorkoutRecord(
                date: weekAgo,
                exerciseName: "풀업",
                sets: 3,
                reps: 15
            )
            modelContext.insert(workout4)
        }

        modelContext.insert(workout1)

        try? modelContext.save()
    }

    public var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 30) {
                    CalendarViewRepresentable(
                        exerciseDates: exerciseDates,
                        onDateSelected: { date in
                            // 해당 날짜에 운동 기록이 있을 때만 push
                            let calendar = Calendar.current
                            let selectedDayStart = calendar.startOfDay(for: date)
                            if exerciseDates.contains(selectedDayStart) {
                                navigationPath.append(.workoutHistory(date))
                            }
                        }
                    )
                    .frame(width: 300, height: 300)
                    .padding()
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                        .stroke(
                            Color.black,
                            lineWidth: 2
                        )
                    )

                    Button {
                        navigationPath.append(.exerciseList)
                    } label: {
                        Text("운동하기")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }

                    // 테스트용: 샘플 데이터 추가 버튼
                    Button {
                        addSampleWorkouts()
                    } label: {
                        Text("샘플 운동 데이터 추가")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                }
            }
            .padding(.top, 20)
            .navigationDestination(for: HomeNavigationDestination.self) { destination in
                switch destination {
                case .exerciseList:
                    ExerciseListView(onDismissAll: {
                        navigationPath.removeAll()
                    })
                case .workoutHistory(let date):
                    WorkoutHistoryView(selectedDate: date)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
