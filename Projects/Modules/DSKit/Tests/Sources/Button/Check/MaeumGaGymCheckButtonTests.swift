import XCTest
import DSKit

class MaeumGaGymCheckButtonTests: XCTestCase {

    func test_버튼초기상태() {
        let checkButton = MGCheckButton()

        XCTAssertEqual(checkButton.textLabel.text, "", "텍스트는 빈 문자열이어야 합니다.")
        XCTAssertEqual(checkButton.backgroundColor, DSKitAsset.Colors.gray400.color, "배경 색은 기본값과 일치해야 합니다.")
        XCTAssertEqual(checkButton.textLabel.textColor, DSKitAsset.Colors.gray200.color, "텍스트 색은 기본값과 일치해야 합니다.")
        XCTAssertEqual(checkButton.layer.cornerRadius, 8.0, "코너 라디우스는 기본값과 일치해야 합니다.")
    }

    func test_버튼사용자지정() {
        let text = "확인"
        let radius = 10.0
        let textColor = UIColor.red
        let backColor = UIColor.blue

        let checkButton = MGCheckButton(text: text, radius: radius, textColor: textColor, backColor: backColor)

        XCTAssertEqual(checkButton.textLabel.text, text, "텍스트는 설정한 값과 일치해야 합니다.")
        XCTAssertEqual(checkButton.backgroundColor, backColor, "배경 색은 설정한 값과 일치해야 합니다.")
        XCTAssertEqual(checkButton.textLabel.textColor, textColor, "텍스트 색은 설정한 값과 일치해야 합니다.")
        XCTAssertEqual(checkButton.layer.cornerRadius, radius, "코너 라디우스는 설정한 값과 일치해야 합니다.")
    }
}
