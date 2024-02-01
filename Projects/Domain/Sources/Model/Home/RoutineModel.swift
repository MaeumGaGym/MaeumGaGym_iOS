import UIKit

public struct RoutineModel {
    public var exercise: String
    public var sets: Int
    public var reps: Int
    
    public init(exercise: String, sets: Int, reps: Int) {
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
    }
}
