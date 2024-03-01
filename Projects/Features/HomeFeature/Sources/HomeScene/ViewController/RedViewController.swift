//
//  RedViewController.swift
//  HomeFeature
//
//  Created by 박준하 on 2/29/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxFlow

import Core

public class RedViewController: UIViewController, Stepper {
    public var steps = PublishRelay<Step>()
    
    var disposeBag = DisposeBag()
    
    lazy var backButton = UIButton().then {
        $0.setTitle("뒤로가기", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(backButton)
        
        
        backButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(100.0)
        }
        
        backButton.rx.tap
            .subscribe(onNext: {
                HomeStepper.shared.steps.accept(MGStep.homeBack)
            }).disposed(by: disposeBag)
    }
}
