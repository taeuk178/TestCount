import Foundation
import SwiftData
import TestShared

@Observable
public final class WorkoutService {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // Create
    public func addWorkout(
        date: Date,
        exerciseName: String,
        sets: Int,
        reps: Int,
        notes: String? = nil
    ) {
        let workout = WorkoutRecord(
            date: date,
            exerciseName: exerciseName,
            sets: sets,
            reps: reps,
            notes: notes
        )
        modelContext.insert(workout)
        try? modelContext.save()
    }

    // Read - 특정 날짜의 운동 기록
    public func fetchWorkouts(for date: Date) -> [WorkoutRecord] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let predicate = #Predicate<WorkoutRecord> { workout in
            workout.date >= startOfDay && workout.date < endOfDay
        }

        let descriptor = FetchDescriptor<WorkoutRecord>(predicate: predicate)

        return (try? modelContext.fetch(descriptor)) ?? []
    }

    // Read - 모든 운동 기록
    public func fetchAllWorkouts() -> [WorkoutRecord] {
        let descriptor = FetchDescriptor<WorkoutRecord>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    // Read - 운동한 날짜들 가져오기
    public func fetchWorkoutDates() -> Set<Date> {
        let workouts = fetchAllWorkouts()
        let calendar = Calendar.current
        return Set(workouts.map { calendar.startOfDay(for: $0.date) })
    }

    // Update
    public func updateWorkout(_ workout: WorkoutRecord) {
        try? modelContext.save()
    }

    // Delete
    public func deleteWorkout(_ workout: WorkoutRecord) {
        modelContext.delete(workout)
        try? modelContext.save()
    }

    // Delete - 특정 날짜의 모든 운동 기록 삭제
    public func deleteWorkouts(for date: Date) {
        let workouts = fetchWorkouts(for: date)
        workouts.forEach { modelContext.delete($0) }
        try? modelContext.save()
    }
}
