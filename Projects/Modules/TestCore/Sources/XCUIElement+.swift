import XCTest

public extension XCUIElement {
    func tapIfExist() {
        if self.exists {
            self.tap()
        }
    }
}
