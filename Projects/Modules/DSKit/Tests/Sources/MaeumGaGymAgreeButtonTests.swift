import XCTest
import DSKit

class MaeumGaGymAgreeButtonTests: XCTestCase {

    var agreeButton: MaeumGaGymAgreeButton!

    override func setUp() {
        super.setUp()
        agreeButton = MaeumGaGymAgreeButton(text: .privacyAgreeText)
    }

    override func tearDown() {
        agreeButton = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertFalse(agreeButton.checked, "기본 초기화에서 선택되는지 확인합니다.")
        XCTAssertEqual(agreeButton.iconImageView.image, DSKitAsset.Assets.noCheck.image, "기본 초기화 이미지는 'noCheck' 입니다.")
    }

    func testButtonYesChecked() {
        agreeButton.buttonYesChecked()
        XCTAssertTrue(agreeButton.checked, "버튼이 클릭된 상태를 확인합니다.")
        XCTAssertEqual(agreeButton.iconImageView.image, DSKitAsset.Assets.yesCheck.image, "버튼이 클릭되면 이미지는 'yesCheck' 입니다.")
    }

    func testButtonNoChecked() {
        agreeButton.buttonNoChecked()
        XCTAssertFalse(agreeButton.checked, "버튼 상태를 선택 취소했을 때 상태를 확인합니다.")
        XCTAssertEqual(agreeButton.iconImageView.image, DSKitAsset.Assets.noCheck.image, "버튼이 다시 비활성화되면 이미지는 'noCheck' 입니다.")
    }

//    func testEditButtonType() {
//        let newText = "새로운 동의 텍스트"
//        agreeButton.editButtonType(text: newText, readMoreType: true)
//
//        XCTAssertEqual(agreeButton.textLabel.text, newText, "텍스트를 업데이트 했을 때 상태를 확인합니다.")
//        XCTAssertTrue(agreeButton.readMore.isHidden == false && agreeButton.readMoreLine.isHidden == false, "Read more components should be visible")
//    }
}
