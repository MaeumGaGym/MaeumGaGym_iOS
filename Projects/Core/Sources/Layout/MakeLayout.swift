import Foundation

public protocol MakeLayout: AnyObject {
    
    var didMakeConstraints: Bool { get set }
    
    func addSubViews()
    func makeConstraints()
}

public extension MakeLayout {
    func makeLayout() {
        self.addSubViews()
        self.makeConstraintsIfNeeded()
    }
    
    func makeConstraintsIfNeeded() {
        if !self.didMakeConstraints {
            self.makeConstraints()
            self.didMakeConstraints = true
        }
    }
}
