import Foundation
import UIKit

public enum PickleLogoType: String, RawRepresentable {
    case hart
    case comment
    case share
    case dots
    case redHart
    
    public var imageLogo: UIImage? {
        switch self {
        case .hart:
            return DSKitAsset.Assets.heart.image
        case .comment:
            return DSKitAsset.Assets.comment.image
        case .share:
            return DSKitAsset.Assets.share.image
        case .dots:
            return DSKitAsset.Assets.dots.image
        case .redHart:
            return DSKitAsset.Assets.redHaert.image
        }
    }

    public var backgroundColor: UIColor? {
        switch self {
        case .hart, .comment, .share, .dots, .redHart:
            return DSKitAsset.Colors.gray50.color.withAlphaComponent(0.12)
        }
    }
    
    public var titleColor: UIColor? {
        switch self {
        case .hart:
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
