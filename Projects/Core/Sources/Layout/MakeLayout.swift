import Foundation

public protocol MakeLayout: AnyObject {
    
    var didMakeConstraints: Bool { get set }
    
    func addSubViews()
    func makeConstraints()
}

public extension MakeLayout {
    func makeLayout() {
        addSubViews()
        makeConstraintsIfNeeded()
    }
    
    func makeConstraintsIfNeeded() {
        if !didMakeConstraints {
            makeConstraints()
            didMakeConstraints = true
        }
    }
}
