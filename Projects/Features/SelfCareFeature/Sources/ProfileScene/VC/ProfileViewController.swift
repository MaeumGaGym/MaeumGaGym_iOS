import UIKit
import SelfCareFeatureInterface

import MGNetworks
import Domain

import RxSwift
import RxCocoa
import RxFlow

import DSKit
import Core

import MGLogger

final public class SelfCareProfileViewController: BaseViewController<SelfCareProfileViewModel>, Stepper {

    private lazy var navBar = SelfCareProfileNavigationBar(leftText: "내 프로필")

    private lazy var userProfileImageView = MGProfileView(
        profileImage: MGProfileImage(
            type: .custom,
            customImage: .basicProfileIcon
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

    public override func bindViewModel() {
        super.bindViewModel()

//        let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
//        viewModel = PostureSearchViewModel(useCase: useCase)

//        let input = PostureSearchViewModel.Input(
//            getSearchData: Observable.just(()).asDriver(onErrorDriveWith: .never())
//        )
        let input = SelfCareProfileViewModel.Input(
            getProfileData: Observable.just(()).asDriver(onErrorDriveWith: .never())
        )
        
        let viewModel = viewModel.transform(input, action: { output in
            output.profileData
                .subscribe(onNext: { profileData in
                    self.userNameLabel.text = profileData.userName
//                    profileData.
                    self.bageView.userTimeLabel.text = profileData.userWakaTime
//                    self.userProfileImageView.profileImage?.customImage. = profileData.userImage
                }).disposed(by: disposeBag)
        })
        
//        beforeButton.rx.tap.subscribe(onNext: {
//            PostureStepper.shared.steps.accept(MGStep.postureBack)
//        }).disposed(by: disposeBag)

//        _ = viewModel.transform(input, action: { optput in
//            optput.searchData
//                .subscribe(onNext: { searchData in
//                    MGLogger.debug("searchData: \(searchData)")
//                    self.searchModel = searchData
//                }).disposed(by: disposeBag)
//            }
//        )
    }
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
