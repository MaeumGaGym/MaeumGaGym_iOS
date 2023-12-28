//
//  PickleInfoView.swift
//  PickleFeatureInterface
//
//  Created by 박준하 on 12/28/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import DSKit
import Pickle
import PickleFeatureInterface

public class PickleInfoView: UIView {
    
    private var userProfile = UserProfileView(userName: "박준하")
    
    private var titlePickleView = TitlePickleView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([userProfile, titlePickleView])
        userProfile.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.height.equalTo(36.0)
        }
        
        titlePickleView.snp.makeConstraints {
            $0.leading.equalTo(userProfile.snp.trailing)
            $0.top.equalTo(userProfile.snp.bottom).offset(18.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
