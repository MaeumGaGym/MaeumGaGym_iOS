//
//  HomeDetailViewController.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import UIKit
import RxSwift

import Core

class HomeDetailViewController: UIViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bind()
    }

    private func bind() {
        backButton.rx.tap
            .subscribe(onNext: {
                TestHomeSteppers.shared.steps.accept(TetstMainSteps.back)
            }).disposed(by: disposeBag)
    }

    lazy var titleLabel = UILabel().then {
        $0.text = "Info"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
    }

    lazy var backButton = UIButton().then {
        $0.setTitle("뒤로가기", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }

    private func setupLayout() {
        view.backgroundColor = .white
    
        view.addSubview(titleLabel)
        view.addSubview(backButton)

        titleLabel.snp.makeConstraints { $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide) }

        backButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 150, height: 40))
        }
    }
}
