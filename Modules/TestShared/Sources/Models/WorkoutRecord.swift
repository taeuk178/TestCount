import Foundation
import SwiftData

@Model
public final class WorkoutRecord {
    public var id: UUID
    public var date: Date
    public var exerciseName: String
    public var sets: Int
    public var reps: Int
    public var notes: String?

    public init(
        id: UUID = UUID(),
        date: Date,
        exerciseName: String,
        sets: Int,
        reps: Int,
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.exerciseName = exerciseName
        self.sets = sets
        self.reps = reps
        self.notes = notes
    }
}
