import XCTest
import MGNetworks
import MGLogger

final class IntroServiceTests: XCTestCase {

    var introService: AuthService!
        
        override func setUp() {
            super.setUp()
            introService = AuthService()
        }
        
        func testRequestToken() {
            let expectation = self.expectation(description: "Token requested")
            var result: Bool?
            
            _ = introService.requestToken().subscribe(onSuccess: { value in
                result = value
                expectation.fulfill()
            })
            
            waitForExpectations(timeout: 5, handler: { error in
                if error == nil {
                    MGLogger.debug("testRequestToken에 성공적으로 실행했습니다.")
                } else {
                    MGLogger.error("\(String(describing: error)) timeOut")
                }
            })
            XCTAssertTrue(result ?? false)
        }
        
        func testKakaoLogin() {
            let expectation = self.expectation(description: "Logged in with Kakao")
            var result: String?
            
            _ = introService.kakaoLogin().subscribe(onSuccess: { value in
                result = value
                expectation.fulfill()
            })
            
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNotNil(result)
        }
        
        override func tearDown() {
            introService = nil
            super.tearDown()
        }
}
