import Foundation
import UIKit

public enum PickleLogoType: String, RawRepresentable {
    case heart
    case comment
    case share
    case dots
    case redHart
    
    public var imageLogo: UIImage? {
        switch self {
        case .heart:
            return DSKitAsset.Assets.heartActIcon.image
        case .comment:
            return DSKitAsset.Assets.commentActIcon.image
        case .share:
            return DSKitAsset.Assets.shareActIcon.image
        case .dots:
            return DSKitAsset.Assets.dotsActIcon.image
        case .redHart:
            return DSKitAsset.Assets.redHaertActIcon.image
        }
    }

    public var backgroundColor: UIColor? {
        switch self {
        case .heart, .comment, .share, .dots, .redHart:
            return DSKitAsset.Colors.gray50.color.withAlphaComponent(0.12)
        }
    }
    
    public var titleColor: UIColor? {
        switch self {
        case .heart:
            return UIColor.white
        case .comment:
            return UIColor.white
        case .share:
            return UIColor.white
        case .dots:
            return UIColor.white
        case .redHart:
            return UIColor.white
        }
    }
}
