import UIKit

import RxFlow
import RxCocoa
import RxSwift

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
    
//    let config = GIDConfiguration(clientID: "9435200486-2epc0q27qhose5v9gkjr5vfa7o97md9u.apps.googleusercontent.com")


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

        let width = view.frame.width / 430.0
        let height = view.frame.height / 932.0

        view.addSubviews([introImageView,
                          mainTitle,
                          subTitle,
                          stackView])

        stackView.addArrangedSubviews(googleButton,
                                      kakaoButton,
                                      appleButton)

        introImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(105.0 * height)
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
            $0.top.equalTo(subTitle.snp.bottom).offset(20.0 * height)
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

        let ouput = viewModel.transform(input, action: { output in
            output.introDatas
                .subscribe(onNext: { introData in
                    self.introModel = introData
                    self.mainTitle.text = self.introModel?.mainTitle
                    self.subTitle.text = self.introModel?.subTitle
                })
                .disposed(by: disposeBag)
        })

        appleButton.rx.tap
            .bind {
                let appleProvider = ASAuthorizationAppleIDProvider()
                let request = appleProvider.createRequest()
                request.requestedScopes = [.fullName, .email]
//
                let controller = ASAuthorizationController(authorizationRequests: [request])
                controller.delegate = self
                controller.performRequests()
            }
            .disposed(by: disposeBag)
     }
}

extension IntroViewController: ASAuthorizationControllerDelegate,
                               ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    public func authorizationController(controller: ASAuthorizationController,
                                        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
            }

            print("useridentifier: \(userIdentifier)")
            print("fullName: \(String(describing: fullName))")
            print("email: \(String(describing: email))")

        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password

            print("username: \(username)")
            print("password: \(password)")

        default:
            break
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
}
