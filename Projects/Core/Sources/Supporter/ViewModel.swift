//
//  ViewModel.swift
//  Core
//
//  Created by 박준하 on 2/27/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

public protocol ViewModel {
}

public protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services! { get set }
}

public protocol ViewModelProtocol: AnyObject {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

public extension ViewModelProtocol where Self: UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}
