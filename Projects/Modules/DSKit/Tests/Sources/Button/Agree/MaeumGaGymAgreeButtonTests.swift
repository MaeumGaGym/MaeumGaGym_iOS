import XCTest
import DSKit

class MaeumGaGymAgreeButtonTests: XCTestCase {

    var agreeButton: MGAgreeButton!

    override func setUp() {
        super.setUp()
        agreeButton = MGAgreeButton(text: .privacyAgreeText)
    }

    override func tearDown() {
        agreeButton = nil
        super.tearDown()
    }

    func test_버튼초기상태() {
        XCTAssertFalse(agreeButton.checked, "기본 초기화에서 선택되는지 확인합니다.")
        XCTAssertEqual(agreeButton.iconImageView.image, DSKitAsset.Assets.noCheck.image, "기본 초기화 이미지는 'noCheck' 입니다.")
    }

    func test_클릭된상태_확인() {
        agreeButton.buttonYesChecked()
        XCTAssertTrue(agreeButton.checked, "버튼이 클릭된 상태를 확인합니다.")
        XCTAssertEqual(agreeButton.iconImageView.image,
                       DSKitAsset.Assets.yesCheck.image,
                       "버튼이 클릭되면 이미지는 'yesCheck' 입니다.")
    }

    func test_클릭되지않은상태_확인() {
        agreeButton.buttonNoChecked()
        XCTAssertFalse(agreeButton.checked, "버튼 상태를 선택 취소했을 때 상태를 확인합니다.")
        XCTAssertEqual(agreeButton.iconImageView.image,
                       DSKitAsset.Assets.noCheck.image,
                       "버튼이 다시 비활성화되면 이미지는 'noCheck' 입니다.")
    }
}
