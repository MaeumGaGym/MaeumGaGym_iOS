//
//  UIStackView+Utils.swift
//  Core
//
//  Created by 박준하 on 11/30/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ viewsToAdd: UIView...) {
        viewsToAdd.forEach { addArrangedSubview($0) }
    }
}
