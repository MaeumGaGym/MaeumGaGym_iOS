//
//  TokenManager.swift
//  TokenManager
//
//  Created by 박준하 on 2/6/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public protocol TokenManager {
        
    func get(key: KeychainType) -> String?
    
    @discardableResult
    func save(token: String, with key: KeychainType) -> Bool
    
    @discardableResult
    func update(token: String, with key: KeychainType) -> Bool
    
    @discardableResult
    func delete(key: KeychainType) -> Bool
}
