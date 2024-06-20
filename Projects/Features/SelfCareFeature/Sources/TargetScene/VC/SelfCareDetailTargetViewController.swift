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
    
    private let loadDetailTargetRelay = PublishRelay<Int>()
    
    public var targetID: Int = 0

    private let navBar = SelfCareProfileNavigationBar()
    private let dotButton = MGImageButton(image: .blackDosActIcon)
    private let targetTitleLabel = MGLabel(
        font: UIFont.Pretendard.titleLarge,
        textColor: .black
    )
    private let startDateBannerView = MGSelfCareTargetDateBannerView(typeText: "시작")
    private let endDateBannerView = MGSelfCareTargetDateBannerView(typeText: "마감")
    private let targetContentLabel = MGLabel(
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
        
        loadDetailTargetRelay.accept(targetID)
    }
    public override func bindViewModel() {
        let input = SelfCareDetailTargetViewModel.Input(
            loadDetailTargetData: loadDetailTargetRelay.asDriver(onErrorJustReturn: 0),
            popVCButton: navBar.leftButtonTap.asDriver()
        )
        
        _ = viewModel.transform(input, action: { output in
            output.detailTargetData
                .withUnretained(self)
                .subscribe(onNext: { owner, data in
                    owner.targetTitleLabel.changeText(text: data.targetTitle)
                    owner.startDateBannerView.setup(dateText: data.targetStartDate)
                    owner.endDateBannerView.setup(dateText: data.targetEndDate)
                    owner.targetContentLabel.changeText(text: data.content)
                }).disposed(by: disposeBag)
        })
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
