//
//  SettingView.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//
import UIKit
import RxSwift
import RxRelay

class SettingView: UIView {
    var disposeBag = DisposeBag()
    let actionRelay = PublishRelay<SettingActionType>()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Dependency Injection
    func setupDI(observable: PublishRelay<SettingActionType>) {
        actionRelay.bind(to: observable).disposed(by: disposeBag)
    }

    // MARK: Binding
    private func bind() {
        firstVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.actionRelay.accept(.nextScreen(step: .firstRequired))
            }).disposed(by: disposeBag)

        secondVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.actionRelay.accept(.nextScreen(step: .modalRequired))
            }).disposed(by: disposeBag)
    }

    lazy var titleLabel = UILabel().then {
        $0.text = "설정"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
    }

    lazy var stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
    }

    lazy var firstVCButton = UIButton().then {
        $0.setTitle("Move To FirstVC", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }

    lazy var secondVCButton = UIButton().then {
        $0.setTitle("Show Modal", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }

    private func setupLayout() {
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(stack)

        stack.addArrangedSubview(firstVCButton)
        stack.addArrangedSubview(secondVCButton)

        titleLabel.snp.makeConstraints { $0.top.leading.trailing.equalTo(safeAreaLayoutGuide) }

        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
    }
}
