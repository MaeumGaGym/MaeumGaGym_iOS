import UIKit

public struct SelfCareModifyProfile {
    public var name: String
    public var height: Double
    public var weight: Double
    public var gender: String//임시 enum으로 바꿔야됨
    
    public init(name: String, height: Double, weight: Double, gender: String) {
        self.name = name
        self.height = height
        self.weight = weight
        self.gender = gender
    }

}
