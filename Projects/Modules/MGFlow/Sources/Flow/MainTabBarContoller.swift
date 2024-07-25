import Foundation
import Data
import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core
import DSKit

import Domain
import SnapKit
import MGNetworks

import HomeFeatureInterface
import PickleFeatureInterface
import ShopFeatureInterface
import SelfCareFeatureInterface
import PostureFeatureInterface

public class MainTabBarContoller: UITabBarController {
    public static let shared = MainTabBarContoller()
    
    private let tabBarLine = MGLine(lineColor: DSKitAsset.Colors.gray100.color, lineHeight: 1)

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        self.tabBar.tintColor = DSKitAsset.Colors.blue500.color
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.addSubview(tabBarLine)
        
        tabBarLine.snp.makeConstraints {
            $0.top.leading.trailing.width.equalToSuperview()
            $0.height.equalTo(1.0)
        }
    }
}
