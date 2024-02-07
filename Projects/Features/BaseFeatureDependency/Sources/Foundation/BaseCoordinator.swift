//
//  BaseCoordinator.swift
//  BaseFeatureDependency
//
//  Created by 박준하 on 2/6/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

open class BaseCoordinator: Coordinator {
    
    // MARK: - Vars & Lets
    public var childCoordinators = [Coordinator]()
    
    // MARK: - Public methods
    
    public func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    public func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    // MARK: - Coordinator
    
    open func start() {
        start(with: nil)
    }
    
    open func start(with option: DeepLinkOption?) {
        
    }
    
    open func start(by style: CoordinatorStartingOption) {
        
    }
    
    public init(childCoordinators: [Coordinator] = [Coordinator]()) {
        self.childCoordinators = childCoordinators
    }
}
