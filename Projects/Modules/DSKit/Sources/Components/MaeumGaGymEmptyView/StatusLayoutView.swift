//
//  StatusLayoutView.swift
//  DSKit
//
//  Created by 박준하 on 12/26/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import Then

public class StatusLayoutView: UIView {
    
    let imageView = UIImageView().then {
        $0.adjustsImageSizeForAccessibilityContentSizeCategory = true
        $0.contentMode = .scaleAspectFill
    }

    let messageLabel = UILabel().then {
        $0.textColor = .red
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16.0, weight: .semibold)
        $0.sizeToFit()
    }
    
    public init(message: String, image: UIImage) {
        super.init(frame: .zero)
        
        let emptyimage: UIImage = image

        emptyimage.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red
        imageView.image = emptyimage
        messageLabel.text = message
        
        self.addSubview(imageView)
        self.addSubview(messageLabel)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-80.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80.0)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
