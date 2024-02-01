//
//  MotivationMessageModel.swift
//  Domain
//
//  Created by 박준하 on 1/30/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

public struct MotivationMessageModel {
    public var text: String
    public var author: String
    
    public init(text: String, author: String) {
        self.text = text
        self.author = author
    }
}
