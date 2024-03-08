//
//  ThirdViewController.swift
//  RxFlowTest
//
//  Created by 박준하 on 2/27/24.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

import Core

public class ThirdViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    public var viewModel: SettingViewModel!
    
    var disposeBag = DisposeBag()
    
    let actionRelay = PublishRelay<SettingActionType>()
    
    lazy var thirdView = ThirdView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    private func bind() {
        _ = viewModel.transform(ViewModel.Input(actionTrigger: actionRelay.asObservable()), action: { _ in
            
        })
        thirdView.setupDI(observable: actionRelay)
    }
    
    private func setupLayout() {
        view.addSubview(thirdView)
        thirdView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
