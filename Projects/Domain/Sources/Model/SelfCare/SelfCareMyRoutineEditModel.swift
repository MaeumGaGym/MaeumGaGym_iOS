import UIKit

public struct SelfCareMyRoutineEditModel {
    public var textFieldData: MyRoutineEditTextFieldModel
    public var exerciseData: [MyRoutineEditExerciseModel]

    public init(
        textFieldData: MyRoutineEditTextFieldModel,
        exerciseData: [MyRoutineEditExerciseModel]
    ) {
        self.textFieldData = textFieldData
        self.exerciseData = exerciseData
    }
}

public struct MyRoutineEditTextFieldModel {
    public var textFieldTitle: String
    public var textFieldText: String
    public var textFieldPlaceholder: String

    public init(
        textFieldTitle: String,
        textFieldText: String,
        textFieldPlaceholder: String
    ) {
        self.textFieldTitle = textFieldTitle
        self.textFieldText = textFieldText
        self.textFieldPlaceholder = textFieldPlaceholder
    }
}

public struct MyRoutineEditExerciseModel {
    public var exerciseImage: UIImage
    public var exerciseName: String
    public var textFieldData: [MyRouinteEditExerciseTextFieldModel]

    public init(
        exerciseImage: UIImage,
        exerciseName: String,
        textFieldData: [MyRouinteEditExerciseTextFieldModel]
    ) {
        self.exerciseImage = exerciseImage
        self.exerciseName = exerciseName
        self.textFieldData = textFieldData
    }
}

public struct MyRouinteEditExerciseTextFieldModel {
    public var textFieldTitle: String
    public var exerciseCount: Int

    public init(
        textFieldTitle: String,
        exerciseCount: Int
    ) {
        self.textFieldTitle = textFieldTitle
        self.exerciseCount = exerciseCount
    }
}
