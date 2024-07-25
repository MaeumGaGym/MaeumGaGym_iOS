import UIKit
import SelfCareFeatureInterface

import MGNetworks
import Domain

import RxSwift
import RxCocoa
import RxFlow

import Kingfisher

import DSKit
import Core
import Data

import MGLogger

final public class SelfCareProfileViewController: BaseViewController<SelfCareProfileViewModel> {

    private lazy var navBar = SelfCareProfileNavigationBar(leftText: "내 프로필")

    private lazy var userProfileImageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: .basicProfileIcon
        ), profileType: .maxProfile
    )

    private lazy var userNameLabel = MGLabel(
        text: "",
        font: UIFont.Pretendard.titleMedium,
        textColor: .black
    )
    private lazy var bageView = SelfCareBageView(frame: .init(x: 0, y: 0, width: self.view.frame.width - 40, height: 247))
    private var buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    private var userInfoChangeButton = MGProfileButton(buttonTitle: "내 정보 변경")
    private var logOutButton = MGProfileButton(buttonTitle: "로그아웃")
    private var withdrawalButton = MGProfileButton(buttonTitle: "회원탈퇴")

    public override func bindViewModel() {
        super.bindViewModel()

        let input = SelfCareProfileViewModel.Input(
            getProfileData: Observable.just("조영준").asDriver(onErrorDriveWith: .never()),
            popVC: navBar.leftButtonTap.asDriver(),
            editProfileButton: userInfoChangeButton.rx.tap.asDriver()
        )
        
        _ = viewModel.transform(input, action: { output in
            output.profileData
                .subscribe(onNext: { profileData in
                    self.userNameLabel.changeText(text: profileData.userName)
                    print("userName: \(profileData.userName)")
                    self.bageView.setup(timeText: profileData.userWakaTime)
                    let profileImage = URL(string: profileData.userImage ?? "")
//                    self.userProfileImageView.kf.setImage(with: profileImage)
//                    self.userProfileImageView.profileImage?.customImage. = profileData.userImage
                }).disposed(by: disposeBag)
        })
        
    }
    public override func bindActions() {
        logOutButton.rx.tap
            .asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.showCaveatPopUp(
                    title: "로그아웃",
                    message: "로그아웃 하실건가요?",
                    leftActionTitle: "취소",
                    rightActionTitle: "확인",
                    leftActionCompletion: {
                        MGLogger.debug("leftButtonClick")
                    },
                    rightActionCompletion: { }
                )
                MGLogger.debug("logOutButton")
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
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userNameLabel.snp.bottom).offset(32.0)
            $0.leading.trailing.equalTo(20)
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(bageView.snp.bottom).offset(279.0)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(184.0)
        }
    }
}
