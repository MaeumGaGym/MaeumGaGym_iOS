import Foundation

public struct ServiceStateModel: Equatable {
    public let isAvailable: Bool
    
    public init(isAvailable: Bool) {
        self.isAvailable = isAvailable
    }
}
