import Foundation

public protocol ReuseIdentifier {
    static var identifier: String { get }
    var identifier: String { get }
}


public extension ReuseIdentifier {
    var identifier: String {
        return String(describing: Self.self)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
