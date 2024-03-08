//
//  HomeViewController.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxFlow
import ShopFeatureInterface

import Core

class HomeViewController: UIViewController, Stepper {
    var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bind()
    }

    private func setupLayout() {
        view.backgroundColor = .white

        MainTabBarContollers.shared.tabBarItem.title = "홈"

        view.addSubview(titleLabel)
        view.addSubview(moveButton)

        titleLabel.snp.makeConstraints { $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide) }

        moveButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 150, height: 40))
        }
    }

    // MARK: Binding
    private func bind() {
        moveButton.rx.tap
            .subscribe(onNext: {
                TestHomeSteppers.shared.steps.accept(TetstMainSteps.infoRequired)
            }).disposed(by: disposeBag)
    }

    // MARK: View
    lazy var titleLabel = UILabel().then {
        $0.text = "Home"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
    }

    lazy var moveButton = UIButton().then {
        $0.setTitle("Move To InfoVC", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }
}
