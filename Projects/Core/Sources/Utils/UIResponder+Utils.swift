//
//  UIResponder+Utils.swift
//  Core
//
//  Created by 박준하 on 12/31/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import UIKit

public extension UIResponder {
    func findViewController() -> UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        } else {
            return self.next?.findViewController()
        }
    }
}
