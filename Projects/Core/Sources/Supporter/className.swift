//
//  ㅁㄴㅇㄹ.swift
//  Core
//
//  Created by 박준하 on 12/26/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
