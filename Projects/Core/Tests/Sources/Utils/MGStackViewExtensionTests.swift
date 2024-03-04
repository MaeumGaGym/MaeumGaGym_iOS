import XCTest
import Core

final class MGStackViewExtensionTests: XCTestCase {
    public var stackView = UIStackView()

    func test_세개의_서브뷰를_스택뷰안에_넣었을_경우() {
        // Given
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()

        // When
        stackView.addArrangedSubviews(view1, view2, view3)

        // Then
        XCTAssertEqual(stackView.arrangedSubviews.count, 3)
        XCTAssertTrue(stackView.arrangedSubviews.contains(view1))
        XCTAssertTrue(stackView.arrangedSubviews.contains(view2))
        XCTAssertTrue(stackView.arrangedSubviews.contains(view3))
    }
}
