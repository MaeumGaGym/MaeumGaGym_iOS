import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import Data
import DSKit

import Domain
import MGLogger
import MGNetworks

import BaseFeatureDependency
import AuthenticationServices

public class IntroViewController: BaseViewController<IntroViewModel>, Stepper {

    public var steps = PublishRelay<Step>()

    private var introModel: IntroModel?

    private var introImageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: nil),
        profileType: .intro
    )

    private var mainTitle = MGLabel(
        font: UIFont.Pretendard.titleMedium,
        isCenter: true
    )

    private var subTitle = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray600.color,
        numberOfLineCount: 2
    )

    private var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 16.0
    }

    private var googleButton = MGAuthButton(type: .google)
    private var kakaoButton = MGAuthButton(type: .kakao)
    private var appleButton = MGAuthButton(type: .apple)

    public override func layout() {
        super.layout()

        view.addSubviews([introImageView,
                          mainTitle,
                          subTitle,
                          stackView])

        stackView.addArrangedSubviews(googleButton,
                                      kakaoButton,
                                      appleButton)

        introImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(158.0)
        }

        mainTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(introImageView.snp.bottom).offset(30.0 * height)
        }

        subTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainTitle.snp.bottom).offset(10.0 * height)
        }

        googleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(390.0 * width)
            $0.height.equalTo(60.0 * height)
        }

        kakaoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(390.0 * width)
            $0.height.equalTo(60.0 * height)
        }

        appleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(390.0 * width)
            $0.height.equalTo(60.0 * height)
        }

        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subTitle.snp.bottom).offset(68.0)
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()

        let useCase = DefaultAuthUseCase(authRepository: AuthRepository(networkService: AuthService()))
        viewModel = IntroViewModel(authUseCase: useCase)

        let input = IntroViewModel.Input(
            goolgeButtonTapped: googleButton.rx.tap.asDriver(),
            appleButtonTapped: appleButton.rx.tap.asDriver(),
            kakaoButtonTapped: kakaoButton.rx.tap.asDriver(),
            getIntroData: Observable.just(()).asDriver(onErrorDriveWith: .never())
        )

        _ = viewModel.transform(input, action: { output in
            output.introDatas
                .subscribe(onNext: { [weak self] introData in
                    self?.introModel = introData
                    self?.mainTitle.changeText(text: self?.introModel?.mainTitle)
                    self?.subTitle.changeText(text: self?.introModel?.subTitle)
                })
                .disposed(by: disposeBag)
        })
    }
}
