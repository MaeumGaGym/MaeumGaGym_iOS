import XCTest
import Core

final class MGUIViewExtesnsionTests: XCTestCase {
    public var mainView = UIView()

    func test_세개의_서브뷰를_addSubView에_넣었을_경우() {
        // Given
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
                
        // When
        mainView.addSubviews([view1, view2, view3])
        
        // Then
        XCTAssertEqual(mainView.subviews.count, 3)
        XCTAssertTrue(mainView.subviews.contains(view1))
        XCTAssertTrue(mainView.subviews.contains(view2))
        XCTAssertTrue(mainView.subviews.contains(view3))
    }
    
    func test_이미지_모서리_둥글게_만들기() {
         // Given
         let radius: CGFloat = 10.0

         // When
        mainView.makeRounded(radius: radius)

         // Then
         XCTAssertTrue(mainView.clipsToBounds)
         XCTAssertEqual(mainView.layer.cornerRadius, radius)
     }
}
