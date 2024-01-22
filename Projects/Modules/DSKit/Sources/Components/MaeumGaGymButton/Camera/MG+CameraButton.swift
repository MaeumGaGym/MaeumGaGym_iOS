//
//  MG+CameraButton.swift
//  DSKit
//
//  Created by 박준하 on 1/22/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation
import UIKit
import Then
import Core

open class MGCameraFeatureButton: BaseButton {
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
    }
    
    private var featureImageView = UIImageView().then {
        $0.tintColor = .white
    }
    
    public init(image: UIImage, radius: Double = 26.0, tintColor: UIColor = .white) {
        super.init(frame: .zero)
        
        featureImageEdit(image: image.withRenderingMode(.alwaysTemplate), radius: radius, tintColor: tintColor)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layout() {
        super.layout()
        
        self.addSubviews([backgroundView, featureImageView])
        
        backgroundView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(52.0)
        }
        
        featureImageView.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView.snp.centerX)
            $0.centerY.equalTo(backgroundView.snp.centerY)
            $0.height.width.equalTo(24.0)
        }
    }
    
    public func featureImageEdit(image: UIImage, radius: Double, tintColor: UIColor) {
        featureImageView.image = image
        featureImageView.tintColor = tintColor
        backgroundView.layer.cornerRadius = radius
    }
}
