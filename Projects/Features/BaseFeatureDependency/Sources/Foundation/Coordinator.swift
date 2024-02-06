//
//  Coordinator.swift
//  BaseFeatureDependency
//
//  Created by 박준하 on 2/6/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public protocol Coordinator: AnyObject {
    func start()
    
    /// DeepLink와 함께 화면전환을 하기 위한 star 메서드입니다.
    /// - Parameter option: DeepLinkOption을 추가하여 DeepLink 기능을 사용할 수 있습니다.
    func start(with option: DeepLinkOption?)
    
    /// CoordinatorStaringOption을 지정하여 원하는 화면전환 액션을 수행합니다.
    /// - Parameter style: modal 또는 Root 등의 옵션을 지정합니다.
    func start(by style: CoordinatorStartingOption)
}
