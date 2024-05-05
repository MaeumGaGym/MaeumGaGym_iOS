import UIKit
import SelfCareFeatureInterface

import MGNetworks
import Domain

import RxSwift
import RxCocoa
import RxFlow

import DSKit
import Core

final public class SelfCareProfileViewController: BaseViewController<SelfCareProfileViewModel>, Stepper {

    private lazy var navBar = SelfCareProfileNavigationBar()

    private lazy var userProfileImageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: DSKitAsset.Assets.basicProfileIcon.image
        ), profileType: .maxProfile
    )

    private lazy var userNameLabel = MGLabel(
        text: "박준하",
        font: UIFont.Pretendard.titleMedium,
        textColor: .black
    )
    private var bageView = SelfCareBageView()
    private var buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    private var userInfoChangeButton = MGProfileButton(buttonTitle: "내 정보 변경")
    private var logOutButton = MGProfileButton(buttonTitle: "로그아웃")
    private var withdrawalButton = MGProfileButton(buttonTitle: "회원탈퇴")

    public override func bindActions() {
        navBar.leftButtonTap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)

        userInfoChangeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.pushViewController(
                    SelfCareProfileEditViewController(SelfCareProfileEditViewModel()),
                    animated: true
                )
            }).disposed(by: disposeBag)

        logOutButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.showCaveatPopUp(
                    title: "로그아웃",
                    message: "로그아웃 하실건가요?",
                    leftActionTitle: "취소",
                    rightActionTitle: "확인",
                    leftActionCompletion: { },
                    rightActionCompletion: { }
                )
            }).disposed(by: disposeBag)

        withdrawalButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.showCaveatPopUp(
                    title: "회원탈퇴",
                    message: "정말 탈퇴하실건가요?\n30일 뒤에 활동이 모두 삭제돼요.",
                    leftActionTitle: "취소",
                    rightActionTitle: "탈퇴",
                    leftActionCompletion: { },
                    rightActionCompletion: { self?.showCaveatPopUp(
                        title: "회원탈퇴 확인",
                        message: "정말 탈퇴하실건가요?",
                        leftActionTitle: "취소",
                        rightActionTitle: "탈퇴",
                        leftActionCompletion: { },
                        rightActionCompletion: {}
                    )}
                )
            }).disposed(by: disposeBag)
    }
    public override func configureNavigationBar() {
        super.configureNavigationBar()

        navigationController?.isNavigationBarHidden = true
    }

    public override func layout() {
        super.layout()

        view.addSubviews([navBar,
                          userProfileImageView,
                          userNameLabel,
                          bageView,
                          buttonStackView
                         ])

        buttonStackView.addArrangedSubviews(
            userInfoChangeButton,
            logOutButton,
            withdrawalButton
        )

        navBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        userProfileImageView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(16.0)
            $0.leading.equalTo(userProfileImageView.snp.leading)
        }

        bageView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(32.0)
            $0.width.equalTo(390)
            $0.centerX.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(bageView.snp.bottom).offset(279.0)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(184.0)
        }
    }
}
