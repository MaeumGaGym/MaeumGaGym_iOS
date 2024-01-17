//
//  Double+Utils.swift
//  Core
//
//  Created by 박준하 on 1/17/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public extension Double {
    func rounded(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self*divisor).rounded() / divisor
    }
}
