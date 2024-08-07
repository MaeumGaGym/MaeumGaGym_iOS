import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import DSKit
import MGLogger

public class CompleteSignUpViewController: BaseViewController<CompleteViewModel> {

    private let mainLogo = UIImageView().then {
        $0.image = DSKitAsset.Assets.mainLogo.image
    }

    private let agreeLabel = MGLabel(
        text: "회원가입 완료",
        font: UIFont.Pretendard.titleLarge
    )

    private let textInformation = MGLabel(
        text: "마음가짐의 회원이 되신 것을 축하드려요!",
        font: UIFont.Pretendard.labelMedium,
        textColor: DSKitAsset.Colors.gray600.color
    )

    private var checkButton = MGCheckButton(
        text: "확인",
        textColor: .white,
        backColor: DSKitAsset.Colors.blue500.color
    )

    public override func layout() {
        view.addSubviews([mainLogo,
                          agreeLabel,
                          textInformation,
                          checkButton])

        mainLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-60.0)
            $0.width.height.equalTo(120.0)
        }

        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(mainLogo.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }

        textInformation.snp.makeConstraints {
            $0.top.equalTo(agreeLabel.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }

        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(58.0)
        }
    }

    public override func bindActions() {
        super.bindActions()
        
        let input = CompleteViewModel.Input(
            checkButtonTapped: checkButton.rx.tap.asDriver()
        )
        
        _ = viewModel.transform(input, action: { _ in
            print("transform 호출")
        })
    }
}
