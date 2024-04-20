import UIKit
import Core

public struct TabItemInfo {
    let title: String
    let image: UIImage
    let selectedImage: UIImage
    let tag: Int
}

public enum MGTabBarType: Int {
    case home = 0, posture, shop, pickle, selfCare
    
    public func tabItemInfo() -> TabItemInfo {
        switch self {
        case .home:
            return TabItemInfo(title: "홈",
                               image: DSKitAsset.Assets.baHomeTapBar.image,
                               selectedImage: DSKitAsset.Assets.blHomeTapBar.image,
                               tag: 0)
        case .posture:
            return TabItemInfo(title: "자세",
                               image: DSKitAsset.Assets.bPeopleTapBar.image,
                               selectedImage: DSKitAsset.Assets.blPeopleTapBar.image,
                               tag: 1)
        case .shop:
            return TabItemInfo(title: "샵",
                               image: DSKitAsset.Assets.baShopTapBar.image,
                               selectedImage: DSKitAsset.Assets.blShopTapBar.image,
                               tag: 2)
        case .pickle:
            return TabItemInfo(title: "피클",
                               image: DSKitAsset.Assets.baPickleTapBar.image,
                               selectedImage: DSKitAsset.Assets.blPickleTapBar.image,
                               tag: 3)
        case .selfCare:
            return TabItemInfo(title: "자기 관리",
                               image: DSKitAsset.Assets.baMuscleTapBar.image,
                               selectedImage: DSKitAsset.Assets.blMuscleTapBar.image,
                               tag: 4)
        }
    }
}

public class MGTabBarTypeItem: UITabBarItem {
    public init(_ type: MGTabBarType) {
        super.init()
        let info = type.tabItemInfo()

        self.title = info.title
        self.image = info.image
        self.selectedImage = info.selectedImage
        self.tag = info.tag
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
