import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import Data
import Domain

import MGNetworks

public class SplashViewController: BaseViewController<SplashViewModel>, Stepper {

    public var steps = PublishRelay<Step>()
    
    private let iconImageView = UIImageView().then {
        $0.image = AuthResourcesService.Assets.splashIcon
    }
    
    public override func layout() {
        view.addSubviews([iconImageView])
        
        iconImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()
        
        let useCase = DefaultAuthUseCase(authRepository: AuthRepository(networkService: AuthService()))
        viewModel = SplashViewModel(authUseCase: useCase)
        
        useCase.splashLogin()
    }
}
