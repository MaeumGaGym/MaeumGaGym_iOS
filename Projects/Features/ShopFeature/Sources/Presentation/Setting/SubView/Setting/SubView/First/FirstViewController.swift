//
//  SettingViewController.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//
import Foundation
import UIKit
import RxSwift
import RxRelay

import Core

class FirstViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    var viewModel: SettingViewModel!

    var disposeBag = DisposeBag()

    let actionRelay = PublishRelay<SettingActionType>()

    lazy var firstView = FirstView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bind()
    }

    private func bind() {
        _ = viewModel.transform(ViewModel.Input(actionTrigger: actionRelay.asObservable()), action: { _ in
            
        })
        firstView.setupDI(observable: actionRelay)
    }

    private func setupLayout() {
        view.addSubview(firstView)
        firstView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
