import XCTest
@testable import DSKit

class MaeumGaGymAuthButtonTests: XCTestCase {
    func testButtonInitialization() {
        // Given
        let type = AuthLogoType.kakao

        // When
        let button = MaeumGaGymAuthButton(type: type)

        // Then
        XCTAssertEqual(button.backgroundColor, type.backgroundColor)
        XCTAssertEqual(button.layer.cornerRadius, 8.0)
    }
}
