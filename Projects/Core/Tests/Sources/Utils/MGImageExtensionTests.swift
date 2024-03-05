import XCTest
import Core

final class MGImageExtensionTests: XCTestCase {
    var testImage = UIImage()

    func test_테스트_크기조정을_할_경우() {
        // Given
        let newWidth: CGFloat = 100.0
        let newHeight: CGFloat = 200.0

        // When
        let resizedImage = testImage.resized(toWidth: newWidth, height: newHeight)

        // Then
        XCTAssertEqual(resizedImage?.size.width, newWidth)
        XCTAssertEqual(resizedImage?.size.height, newHeight)
    }
}
