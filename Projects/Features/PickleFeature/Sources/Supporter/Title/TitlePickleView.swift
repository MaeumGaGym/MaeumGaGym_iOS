//
//  TitlePickleView.swift
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

open class TitlePickleView: UIView {

    private let telUILabel = MaeumGaGymAuthLabel(text: "상쾌한 날씨의 오늘", font: UIFont.Pretendard.titleMedium, textColor: .white)
    
    private let textInformation = MaeumGaGymAuthLabel(text: "날씨가 정말 좋네요. 오늘은 정말 산책하기 좋을 것 같아요.", font: UIFont.Pretendard.bodyMedium2, textColor: .white)

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(telUILabel)
        addSubview(textInformation)
    }

    private func setupConstraints() {
        telUILabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        textInformation.snp.makeConstraints {
            $0.top.equalTo(telUILabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(telUILabel.snp.leading)
        }
    }
}
