//
//  MotivationMessageTableViewCell.swift
//  HomeFeatureInterface
//
//  Created by 박준하 on 1/25/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import DSKit
import Core

public class MotivationMessageTableViewCell: UITableViewCell {

    static public var identifier: String = "MotivationMessageTableViewCell"

    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = DSKitAsset.Colors.blue500.color
    }
    private let authorLabel = UILabel().then {
        $0.font = UIFont.Pretendard.labelMedium
        $0.textColor = DSKitAsset.Colors.gray500.color
    }

     private var disposeBag = DisposeBag()

     func configure(with message: MotivationMessageModel) {
         messageLabel.text = "\"\(message.text)\""
         authorLabel.text = "\(message.author)"
     }

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupUI()
     }

    required public init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func setupUI() {
         addSubview(messageLabel)
         messageLabel.snp.makeConstraints {
             $0.top.equalToSuperview()
             $0.leading.trailing.equalToSuperview().inset(12)
             $0.bottom.lessThanOrEqualToSuperview().inset(8).priority(.high)
         }

         addSubview(authorLabel)
         authorLabel.snp.makeConstraints {
             $0.top.equalTo(messageLabel.snp.bottom).offset(8)
             $0.leading.equalTo(messageLabel.snp.leading)
             $0.bottom.equalToSuperview()
         }

         rx.deallocated
             .bind { [weak self] in
                 self?.disposeBag = DisposeBag()
             }
             .disposed(by: disposeBag)
     }
}
