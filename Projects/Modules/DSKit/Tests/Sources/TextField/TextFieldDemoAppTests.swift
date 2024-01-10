import XCTest
import DSKit

final class MaeumGaGymTextFieldTests: XCTestCase {
    
    var textField: MaeumGaGymTextField!

    override func setUpWithError() throws {
        textField = MaeumGaGymTextField()
    }

    override func tearDownWithError() throws {
        textField = nil
    }

    func test에러표시() {
        textField.showError = true
        XCTAssertTrue(textField.errorLabel.isHidden == false)
        XCTAssertTrue(textField.underlineView.backgroundColor == UIColor.red)
        XCTAssertTrue(textField.errorLabel.textColor == UIColor.red)
    }

    func test_에러타입_표시확인() {
        textField.nameErrorType = .tooLong
        XCTAssertTrue(textField.errorMessage == textField.nameErrorType?.message)
        XCTAssertTrue(textField.showError == textField.nameErrorType?.showError)
    }

    func test플레이스홀더설정() {
        let placeholderText = "테스트 플레이스홀더"
        textField.placeholder = placeholderText
        XCTAssertTrue(textField.placeholderLabel.text == placeholderText)
    }
}
