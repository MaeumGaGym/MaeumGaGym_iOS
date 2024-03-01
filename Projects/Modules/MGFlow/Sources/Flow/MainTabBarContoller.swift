//
//  MainTabBarContoller.swift
//  MGFlow
//
//  Created by 박준하 on 2/29/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import UIKit

import DSKit

public class MainTabBarContoller: UITabBarController {
    public static let shared = MainTabBarContoller()

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

        tabBar.tintColor = DSKitAsset.Colors.blue500.color
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = DSKitAsset.Colors.gray100.color
    }
}
