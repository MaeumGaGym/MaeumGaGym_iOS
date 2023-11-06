//
//  dummy.swift
//  AuthFeatureInterface
//
//  Created by 박준하 on 11/2/23.
//  Copyright © 2023 Maeumgajim-iOS. All rights reserved.
//

import Foundation
import UIKit
import DSKit

class ViewController: UIViewController {
    
    var Alabel: UILabel {
        let label = UILabel()
        label.text = "asdf"
        label.font = DSKitFontFamily.Pretendard.bold.font(size: 10.0)
        return label
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
