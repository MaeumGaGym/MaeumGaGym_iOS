import Foundation
import Data
import UIKit

import RxFlow
import RxCocoa
import RxSwift

import Core
import DSKit

import Domain
import MGNetworks

import HomeFeatureInterface
import PickleFeatureInterface
import ShopFeatureInterface
import SelfCareFeatureInterface
import PostureFeatureInterface

public class MainTabBarContoller: UITabBarController {
    public static let shared = MainTabBarContoller()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        self.tabBar.tintColor = DSKitAsset.Colors.blue500.color
    }
}
