import UIKit
import Core

public enum MGTabBarType: Int {
    case home = 0
    case posture
    case shop
    case pickle
    case selfCare
}

public extension MGTabBarType {
    func tabItemTuple() -> (String, UIImage, UIImage, Int) {
        switch self {
        case .home:
            return ("홈", DSKitAsset.Assets.baHomeTapBar.image,
                    DSKitAsset.Assets.blHomeTapBar.image, 0)

        case .posture:
            return ("자세", DSKitAsset.Assets.bPeopleTapBar.image,
                    DSKitAsset.Assets.blPeopleTapBar.image, 1)

        case .shop:
            return ("샵", DSKitAsset.Assets.baShopTapBar.image,
                    DSKitAsset.Assets.blShopTapBar.image, 2)

        case .pickle:
            return ("피클", DSKitAsset.Assets.baPickleTapBar.image,
                    DSKitAsset.Assets.blPickleTapBar.image, 3)
        case .selfCare:
            return ("자기 관리", DSKitAsset.Assets.baMuscleTapBar.image,
                    DSKitAsset.Assets.blMuscleTapBar.image, 4)
        }
    }
}

public class MGTabBarTypeItem: UITabBarItem {
    public init(_ type: MGTabBarType) {
        super.init()
        let (title, image1, image2, tag) = type.tabItemTuple()

        self.title = title
        self.image = image1
        self.selectedImage = image2
        self.tag = tag
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
