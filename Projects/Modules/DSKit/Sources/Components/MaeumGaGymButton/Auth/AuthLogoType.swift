import Foundation
import UIKit

public enum AuthLogoType: String, RawRepresentable {
    case kakao
    case google
    case apple
    
    public var imageLogo: UIImage? {
        switch self {
        case .kakao:
            return DSKitAsset.Assets.kakaoLogo.image
        case .google:
            return DSKitAsset.Assets.googleLogo.image
        case .apple:
            return DSKitAsset.Assets.appleLogo.image
        }
    }
    
    public var logoTitle: String? {
        switch self {
        case .kakao:
            return "카카오로 로그인"
        case .google:
            return "구글로 로그인"
        case .apple:
            return "Apple로 로그인"
        }
    }

    public var backgroundColor: UIColor? {
        switch self {
        case .kakao:
            return DSKitAsset.Colors.gray50.color
        case .google:
            return DSKitAsset.Colors.gray50.color
        case .apple:
            return DSKitAsset.Colors.gray50.color
        }
    }
    
    public var titleColor: UIColor? {
        switch self {
        case .kakao:
            return UIColor.black
        case .google:
            return UIColor.black
        case .apple:
            return UIColor.black
        }
    }
}
