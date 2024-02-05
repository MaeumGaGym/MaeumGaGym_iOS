//
//  User.swift
//  Domain
//
//  Created by 박준하 on 2/5/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

public struct User {
    let id: String
    let name: String
    let accessToken: String
    
    public init(id: String, name: String, accessToken: String) {
        self.id = id
        self.name = name
        self.accessToken = accessToken
    }
}
