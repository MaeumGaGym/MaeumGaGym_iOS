import Foundation
import UIKit

public enum TimerButtonType: String {
    case close
    case start
    case stop
    case restart
    
    public var imageLogo: UIImage? {
        switch self {
        case .close:
            return DSKitAsset.Assets.close.image
        case .start:
            return DSKitAsset.Assets.playFilled.image
        case .stop:
            return DSKitAsset.Assets.pause.image
        case .restart:
            return DSKitAsset.Assets.redo.image
        }
    }
    
    public var backgroundColor: UIColor? {
        switch self {
        case .close:
            return .white
        case .start:
            return DSKitAsset.Colors.blue400.color
        case .stop:
            return DSKitAsset.Colors.blue400.color
        case .restart:
            return .white
        }
    }
}

