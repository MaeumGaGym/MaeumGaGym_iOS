import Foundation
import UIKit

public enum PickleLogoType: String, RawRepresentable {
    case hart
    case comment
    case share
    case dots
    
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
        }
    }

    public var backgroundColor: UIColor? {
        switch self {
        case .hart, .comment, .share, .dots:
            return DSKitAsset.Colors.gray50.color.withAlphaComponent(0.12)
        }
    }
    
    public var titleColor: UIColor? {
        switch self {
        case .hart:
            return UIColor.black
        case .comment:
            return UIColor.black
        case .share:
            return UIColor.black
        case .dots:
            return UIColor.black
        }
    }
}
