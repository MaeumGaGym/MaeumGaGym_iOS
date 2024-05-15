import UIKit
import AuthFeatureInterface

import RxSwift
import RxCocoa
import RxFlow

import DSKit

import SnapKit
import Then

import Core

public class SplashViewController: BaseViewController<SplashViewModel>, Stepper {

    private let iconImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.splashLogo.image
    }
    
//    public override func viewDidAppear(_ animated: Bool) {
//        AuthStepper.shared.steps.accept(MGStep.authIntroIsRequired)
//    }
    
    public override func attribute() {
        super.attribute()
    }

    public override func layout() {
        super.layout()
        view.addSubviews([iconImageView])

        iconImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
