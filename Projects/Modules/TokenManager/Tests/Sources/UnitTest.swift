import XCTest
import TokenManager

class TokenManagerTests: XCTestCase {
    
    var tokenManager: TokenManagerImpl!
    
    override func setUp() {
        super.setUp()
        tokenManager = TokenManagerImpl()
    }
    
    override func tearDown() {
        tokenManager = nil
        super.tearDown()
    }
    
    func test_토큰매니져_토큰_저장_여부확인() {
        // 임의의 토큰과 키를 설정
        let testToken = "testToken"
        let testKey = KeychainType.test
        
        // 토큰 저장 테스트
        _ = tokenManager.save(token: testToken, with: testKey)
        
        // 토큰 가져오기 테스트
        _ = tokenManager.get(key: testKey)
        
        // 토큰 업데이트 테스트
        let newToken = "newTestToken"
        _ = tokenManager.update(token: newToken, with: testKey)
        _ = tokenManager.get(key: testKey)
        
        // 토큰 삭제 테스트
        _ = tokenManager.delete(key: testKey)
        let deletedToken = tokenManager.get(key: testKey)
        XCTAssertNil(deletedToken, "Token should be nil after deletion.")
    }
}
