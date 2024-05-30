import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGLogger
import Data

import SelfCareFeatureInterface

public class SelfCareDetailTargetViewController: BaseViewController<SelfCareDetailTargetViewModel> {

    private let navBar = SelfCareProfileNavigationBar()
    private let dotButton = MGImageButton(image: .blackDosActIcon)
    private let targetTitleLabel = MGLabel(
        text: "공부하기",
        font: UIFont.Pretendard.titleLarge,
        textColor: .black
    )
    private let startDateBannerView = MGSelfCareTargetDateBannerView(typeText: "시작", dateText: "102200")
    private let endDateBannerView = MGSelfCareTargetDateBannerView(typeText: "마감", dateText: "ㄹㅇㄴㅁㄹㅇㄴㅁ")
    private let targetContentLabel = MGLabel(
        text: "새해가 다가오기 전까지 열심히 공부하자.\n한 해의 끝도 공부와 함께.",
        font: UIFont.Pretendard.bodyMedium,
        textColor: .black,
        isCenter: false,
        numberOfLineCount: 0
    )

    public override func configureNavigationBar() {
        super.configureNavigationBar()

        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dotButton)
        navigationController?.isNavigationBarHidden = true
    }
    public override func attribute() {
        super.attribute()

        view.backgroundColor = .white
    }
    public override func bindActions() {
        navBar.leftButtonTap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    public override func layout() {
        view.addSubviews([
            navBar,
            targetTitleLabel,
            startDateBannerView,
            endDateBannerView,
            targetContentLabel
        ])

        navBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        targetTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(20)
        }
        startDateBannerView.snp.makeConstraints {
            $0.top.equalTo(targetTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        endDateBannerView.snp.makeConstraints {
            $0.top.equalTo(startDateBannerView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        targetContentLabel.snp.makeConstraints {
            $0.top.equalTo(endDateBannerView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

    }

}
