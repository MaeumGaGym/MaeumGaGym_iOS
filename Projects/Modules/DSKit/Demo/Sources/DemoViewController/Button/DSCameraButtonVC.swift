//
//  DSCameraButtonVC.swift
//  DSKit
//
//  Created by 박준하 on 1/22/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Core
import DSKit

public class DSCameraButtonVC: UIViewController {
    
    var cameraFeatureButton = MGCameraFeatureButton(image: DSKitAsset.Assets.imageActIcon.image)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        view.addSubview(cameraFeatureButton)

        cameraFeatureButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
    }
}
