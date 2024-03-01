//
//  ModalViewController.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import UIKit
import RxSwift
import RxCocoa

import Core

class ModalViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    var viewModel: SettingViewModel!

    var disposeBag = DisposeBag()

    let actionRelay = PublishRelay<SettingActionType>()

    lazy var toastView = ModalView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bind()
    }
    
    private func bind() {
        let _ = viewModel.transform(SettingViewModel.Input(actionTrigger: actionRelay.asObservable()), action: { _ in
            
        })
        toastView.setupDI(observable: actionRelay)
    }

    private func setupLayout() {
        view.addSubview(toastView)
        toastView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
