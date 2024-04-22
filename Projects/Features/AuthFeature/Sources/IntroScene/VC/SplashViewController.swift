import UIKit
import AuthFeatureInterface

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core

public class SplashViewController: BaseViewController<SplashViewModel>, Stepper {

    private let iconImageView = UIImageView().then {
        $0.image = AuthResourcesService.Assets.splashIcon
    }

    public override func layout() {
        view.addSubviews([iconImageView])

        iconImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
