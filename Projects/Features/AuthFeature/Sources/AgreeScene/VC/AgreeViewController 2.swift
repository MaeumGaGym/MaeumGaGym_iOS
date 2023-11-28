import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit

public class AgreeViewController: BaseViewController<AgreeViewModel> {

    public var steps = PublishRelay<Step>()

    public var initialStep: Step {
        AppStep.homeIsRequired
    }

    private let agreeLabel = MaeumGaGymAuthUILabel(text: "약관동의", font: UIFont.Pretendard.titleLarge)

    private let textInformation = MaeumGaGymAuthUILabel(text: "서비스 이용을 위해 필수 약관동의가 필요해요.", font: UIFont.Pretendard.bodyMedium, textColor: DSKitAsset.Colors.gray600.color)

    let agreeTermsView = MaeumGaGymAgreeView(firstAgreeText: .privacyAgreeText, secondAgreeText: .termsAgreeText, thirdAgreeText: .ageAgreeText, fourthAgreeText: .marketingAgreeText)

    var checkButton = MaeumGaGymCheckButton(text: "확인")

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        subscribe()
    }
    
    public override func layout() {
         [
            agreeLabel,
            textInformation,
            agreeTermsView,
            checkButton
         ].forEach { view.addSubview($0) }
        
        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(125.0)
        }
        
        textInformation.snp.makeConstraints {
            $0.top.equalTo(agreeLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(287.0)
        }
        
        agreeTermsView.snp.makeConstraints {
            $0.top.equalTo(textInformation.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().offset(20.0)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(58.0)
        }
    }
    
    public func subscribe() {
        
        let input = AgreeViewModel.Input(allAgreeButtonTap: agreeTermsView.allAgreeButton.rx.tap.asSignal(), firstAgreeButtonTap: agreeTermsView.firstAgreeButton.rx.tap.asSignal(), secondAgreeButtonTap: agreeTermsView.secondAgreeButton.rx.tap.asSignal(), thirdAgreeButtonTap: agreeTermsView.thirdAgreeButton.rx.tap.asSignal(), fourthAgreeButtonTap: agreeTermsView.fourthAgreeButton.rx.tap.asSignal(), nextButtonTap: checkButton.rx.tap.asSignal())
        
        let output = viewModel.transform(input)
        print(output)
        
//        Observable<AgreementButtonType>.merge([
//            agreeTermsUIView.allAgreeButton.rx.tap.map { _ in .allAgree },
//            agreeTermsUIView.firstAgreeButton.rx.tap.map { _ in .requiredFirst },
//            agreeTermsUIView.secondAgreeButton.rx.tap.map { _ in .requiredSecond },
//            agreeTermsUIView.thirdAgreeButton.rx.tap.map { _ in .requiredThird },
//            agreeTermsUIView.fourthAgreeButton.rx.tap.map { _ in .notRequiredFourth }
//        ])
//        .bind(to: viewModel.)
//        
//        
//        let allAgreeIsSelected = BehaviorRelay<Bool>(value: false)
//        let firstAgreeIsSelected = BehaviorRelay<Bool>(value: false)
//        let secondAgreeIsSelected = BehaviorRelay<Bool>(value: false)
//        let thirdAgreeIsSelected = BehaviorRelay<Bool>(value: false)
//        let fourthAgreeIsSelected = BehaviorRelay<Bool>(value: false)
//        
//        input.buttonTapped
//            .bind { type in
//                switch type {
//                case .allAgree:
//                    let preValue = allAgreeIsSelected.value
//                    [allAgreeIsSelected,
//                     firstAgreeIsSelected,
//                     secondAgreeIsSelected,
//                     secondAgreeIsSelected,
//                     fourthAgreeIsSelected]
//                        .forEach { $0.accept(!preValue) }
//                case .requiredFirst:
//                    firstAgreeIsSelected.accept(!firstAgreeIsSelected.value)
//                case .requiredSecond:
//                    secondAgreeIsSelected.accept(!secondAgreeIsSelected.value)
//                case .requiredThird:
//                    thirdAgreeIsSelected.accept(!thirdAgreeIsSelected.value)
//                case .notRequiredFourth:
//                    fourthAgreeIsSelected.accept(!fourthAgreeIsSelected.value)
//                    }
//            }
//            .disposed(by: disposeBag)
//        
//        Observable.combineLatest(
//            firstAgreeIsSelected,
//            secondAgreeIsSelected,
//            thirdAgreeIsSelected,
//            fourthAgreeIsSelected)
//        { $0 && $1 && $2 && $3 }
//        .bind(to: allAgreeIsSelected)
//        .disposed(by: disposeBag)
//
//        let nextButtonIsEnable = Observable.combineLatest(
//            firstAgreeIsSelected,
//            secondAgreeIsSelected,
//            fourthAgreeIsSelected)
//            { $0 && $1 && $2 }
    }
   
}
