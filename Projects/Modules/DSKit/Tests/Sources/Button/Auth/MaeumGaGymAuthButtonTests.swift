import XCTest
import DSKit

class MaeumGaGymAuthButtonTests: XCTestCase {

    func test_인증버튼타입_카카오() {
        let authButton = MGAuthButton(type: .kakao)

        XCTAssertEqual(authButton.textLabel.text, "카카오로 로그인", "텍스트가 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.iconImageView.image, DSKitAsset.Assets.kakaoLogo.image, "이미지가 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.backgroundColor, DSKitAsset.Colors.gray50.color, "배경 색이 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.textLabel.textColor, UIColor.black, "텍스트 색이 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.layer.cornerRadius, 8.0, "코너 라디우스가 기본 값과 일치해야 합니다.")
    }

    func test_인증버튼타입_구글() {
        let authButton = MGAuthButton(type: .google)

        XCTAssertEqual(authButton.textLabel.text, "구글로 로그인", "텍스트가 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.iconImageView.image, DSKitAsset.Assets.googleLogo.image, "이미지가 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.backgroundColor, DSKitAsset.Colors.gray50.color, "배경 색이 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.textLabel.textColor, UIColor.black, "텍스트 색이 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.layer.cornerRadius, 8.0, "코너 라디우스가 기본 값과 일치해야 합니다.")
    }

    func test_인증버튼타입_애플() {
        let authButton = MGAuthButton(type: .apple, radius: 10.0)

        XCTAssertEqual(authButton.textLabel.text, "Apple로 로그인", "텍스트가 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.iconImageView.image, DSKitAsset.Assets.appleLogo.image, "이미지가 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.backgroundColor, DSKitAsset.Colors.gray50.color, "배경 색이 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.textLabel.textColor, UIColor.black, "텍스트 색이 예상과 일치해야 합니다.")
        XCTAssertEqual(authButton.layer.cornerRadius, 10.0, "코너 라디우스가 설정한 값과 일치해야 합니다.")
    }
}
