//
//  PostureFlow.swift
//  RootFeature
//
//  Created by 박준하 on 11/6/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

class PostureFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    init() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.tabBarItem = UITabBarItem(title: "Posture", image: UIImage(systemName: "chart.bar"), selectedImage: nil)
        rootViewController.setViewControllers([viewController], animated: false)
    }

    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}
