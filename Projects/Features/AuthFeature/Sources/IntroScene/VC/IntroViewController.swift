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

import BaseFeatureDependency
import AuthenticationServices

public class IntroViewController: BaseViewController<IntroViewModel>, Stepper {
    
    private var introModel: IntroModel?
    
    private let alertView1 = MGAlertOnlyTitleView(title: "구글 로그인은 준비중입니다!").then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .black
        $0.backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    private var introImageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: nil),
        profileType: .intro
    )
    
    private var mainTitle = MGLabel(
        text: "이제 운동을 시작해 보세요!",
        font: UIFont.Pretendard.titleMedium,
        isCenter: true
    )
    
    private var subTitle = MGLabel(
        text: "마음가짐 서비스를 통해 규칙적인 생활을\n실천해 보세요!",
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
            $0.top.equalToSuperview().offset(158.0)
        }
        
        mainTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(introImageView.snp.bottom).offset(30.0)
        }
        
        subTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainTitle.snp.bottom).offset(10.0)
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

        let input = IntroViewModel.Input(
            goolgeButtonTapped: googleButton.rx.tap.asDriver(),
            appleButtonTapped: appleButton.rx.tap.asDriver(),
            kakaoButtonTapped: kakaoButton.rx.tap.asDriver(),
            getIntroData: Observable.just(()).asDriver(onErrorDriveWith: .never())
        )
        
        _ = viewModel.transform(input, action: { output in
            output.introDatas
                .withUnretained(self)
                .subscribe(onNext: { owner, introData in
                    owner.introModel = introData
                    owner.mainTitle.changeText(text: owner.introModel?.mainTitle)
                    owner.subTitle.changeText(text: owner.introModel?.subTitle)
                })
                .disposed(by: disposeBag)
            
            output.showGoogleAlert
                    .withUnretained(self)
                    .subscribe(onNext: { owner, _ in
                        owner.alertView1.present(on: owner.view)
                    })
                    .disposed(by: disposeBag)
        })
    }
}
