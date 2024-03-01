//
//  MainTabBarController.swift
//  ShopFeatureInterface
//
//  Created by 박준하 on 2/29/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import UIKit

public class MainTabBarContollers: UITabBarController {
    public static let shared = MainTabBarContollers()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .blue

        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true

        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = .black
    }
}
