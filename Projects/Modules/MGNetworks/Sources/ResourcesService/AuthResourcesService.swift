import UIKit

import DSKit

public enum AuthResourcesService {
    public enum Assets {
        public static let google = DSKitAsset.Assets.googleLogo.image
        public static let kakao = DSKitAsset.Assets.kakaoLogo.image
        public static let apple = DSKitAsset.Assets.appleLogo.image
        public static let noCheck = DSKitAsset.Assets.noCheckActIcon.image
        public static let yesCheck = DSKitAsset.Assets.yesCheckActIcon.image
        public static let cancel = DSKitAsset.Assets.circleCancel.image
        public static let mainLogo = DSKitAsset.Assets.mainLogo.image
        public static let leftArrow = DSKitAsset.Assets.blackLeftBarArrow.image
        public static let introIcon = DSKitAsset.Assets.introIcon.image
    }

    public enum Colors {
        public static let gray25 = DSKitAsset.Colors.gray25.color
        public static let gray50 = DSKitAsset.Colors.gray50.color
        public static let gray100 = DSKitAsset.Colors.gray200.color
        public static let gray200 = DSKitAsset.Colors.gray200.color
        public static let gray300 = DSKitAsset.Colors.gray300.color
        public static let gray400 = DSKitAsset.Colors.gray400.color
        public static let gray500 = DSKitAsset.Colors.gray500.color
        public static let gray600 = DSKitAsset.Colors.gray600.color
        public static let blue500 = DSKitAsset.Colors.blue500.color
        public static let red500 = DSKitAsset.Colors.red500.color
    }

    public enum Title {
        public static let introMainTitle = "이제 헬창이 되어보세요!"
        public static let introSubTitle = "저희의 좋은 서비스를 통해 즐거운 헬창 생활을\n즐겨보세요!"
        public static let introGoogleTitle = "구글로 로그인"
        public static let introKaKaoTitle = "카카오로 로그인"
        public static let introAppleTitle = "Apple로 로그인"
        public static let authAgreeTitle = "약관동의"
        public static let authAgreeSubTitle = "서비스 이용을 위해 필수 약관동의가 필요해요."
        public static let authAllAgreeTitle = "모두 동의해요"
        public static let authAgree1Title = "개인정보 수집 이용 동의"
        public static let authAgree2Title = "이용 약관 동의"
        public static let authAgree3Title = "만 14세 이상"
        public static let authAgree4Title = "마케팅 정보 수신 동의"
        public static let authNicknameTitle = "닉네임"
        public static let authNicknameSubTitle = "자신만의 닉네임을 입력해 주세요."
        public static let authCompleteTitle = "회원가입 완료"
        public static let authCompleteSubTitle = "마음가짐의 회원이 되신 것을 축하드려요!"
    }

    public enum Identifier {
        public static let sample: String = ""
    }
}
