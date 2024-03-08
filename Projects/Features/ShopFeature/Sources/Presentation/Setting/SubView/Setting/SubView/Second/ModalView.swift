//
//  ModalView.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import UIKit
import RxSwift
import RxRelay

class ModalView: UIView {
    var disposeBag = DisposeBag()
    let actionRelay = PublishRelay<SettingActionType>()

    lazy var contentView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }

    lazy var titleLabel = UILabel().then {
        $0.text = "ModalView"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .black
    }

    lazy var dismissButton = UIButton().then {
        $0.setTitle("Dismiss", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 4
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        bind()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupDI(observable: PublishRelay<SettingActionType>) {
        actionRelay.bind(to: observable).disposed(by: disposeBag)
    }

    private func bind() {
        dismissButton.rx
            .tap.subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.actionRelay.accept(.dismiss)
            }).disposed(by: disposeBag)
    }

    private func setupLayout() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.702933103)

        addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(dismissButton)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 300, height: 400))
            $0.center.equalToSuperview()
        }

        dismissButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.bottom.leading.trailing.equalToSuperview().inset(40)
        }
    }
}
