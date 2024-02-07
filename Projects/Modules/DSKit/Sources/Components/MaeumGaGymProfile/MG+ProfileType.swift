import Foundation
import UIKit

public enum MGProfileType {
    case smallProfile
    case middleProfile
    case bigProfile
    case intro
    
    var size: CGFloat {
        switch self {
        case .smallProfile:
            return 36.0
        case .middleProfile:
            return 40.0
        case .bigProfile:
            return 48.0
        case .intro:
            return 280.0
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .smallProfile:
            return 18.0
        case .middleProfile:
            return 20.0
        case .bigProfile:
            return 24.0
        case .intro:
            return 140.0
        }
    }
}

public enum MGProfileImageType: Int {
    case custom
}

public struct MGProfileImage {
    public let type: MGProfileImageType
    public let customImage: UIImage?
    
    public init(type: MGProfileImageType, customImage: UIImage?) {
        self.type = type
        self.customImage = customImage
    }
    
    var image: UIImage {
        switch type {
        case .custom:
            guard let customImage = customImage else {
                return DSKitAsset.Assets.blueHome.image
            }
            
            return customImage
        }
    }
}
