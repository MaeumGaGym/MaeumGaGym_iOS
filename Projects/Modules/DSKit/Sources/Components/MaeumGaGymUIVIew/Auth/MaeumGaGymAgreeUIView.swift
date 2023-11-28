import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

public enum AgreementButtonType {
    case allAgree // 전체 동의
    case requiredFirst // 필수 동의 첫번째
    case requiredSecond // 필수 동의 두번째
    case requiredThird // 필수 동의 세번째
    case notRequiredFourth // 선택 사항(마케팅 동의 같은)
}

struct Input {
    let buttonTapped = PublishRelay<AgreementButtonType>()
}

public class AgreeButtonViewModel {
    let input = Input()
    let allAgreeIsSelected = BehaviorRelay<Bool>(value: false)
    let requiredFirstIsSelected = BehaviorRelay<Bool>(value: false)
    let requiredSecondIsSelected = BehaviorRelay<Bool>(value: false)
    let requiredThirdIsSelected = BehaviorRelay<Bool>(value: false)
    let notRequiredFourthIsSelected = BehaviorRelay<Bool>(value: false)
    let nextButtonIsEnable: Observable<Bool>
    
    init() {
        nextButtonIsEnable = Observable.combineLatest(
            requiredFirstIsSelected,
            requiredSecondIsSelected,
            requiredThirdIsSelected,
            notRequiredFourthIsSelected)
        { $0 && $1 && $2 && $3 }
    }
}


open class MaeumGaGymAgreeUIView: UIView {

    let disposeBag = DisposeBag()
    
    
    private let decorateLine1 = MaeumGaGymLine()
    private let allAgreeButton = MaeumGaGymAgreeButton(text: "모두 동의해요", font: UIFont.Pretendard.labelLarge)
    private let decorateLine2 = MaeumGaGymLine()
    private let firstAgreeButton = MaeumGaGymAgreeButton(text: "개인정보 수집 이용 동의", readMoreType: true)
    private let secondAgreeButton = MaeumGaGymAgreeButton(text: "이용 약관 동의", readMoreType: true)
    private let thirdAgreeButton = MaeumGaGymAgreeButton(text: "만 14세 이상")
    private let fourthAgreeButton = MaeumGaGymAgreeButton(text: "마케팅 정보 수신 동의", chooseType: true)
    
    public init () {
        super.init(frame: .zero)
        setupUI()
        
        let viewModel = AgreeButtonViewModel()

        
        viewModel.input.buttonTapped
        .bind { [weak self] type in
            switch type {
            case .allAgree:
                let preValue = viewModel.allAgreeIsSelected.value
                [viewModel.allAgreeIsSelected,
                viewModel.requiredFirstIsSelected,
                viewModel.requiredSecondIsSelected,
                viewModel.requiredThirdIsSelected,
                viewModel.notRequiredFourthIsSelected]
                    .forEach { $0.accept(!preValue)}
                [self?.allAgreeButton, self?.firstAgreeButton, self?.secondAgreeButton, self?.thirdAgreeButton, self?.fourthAgreeButton]
                    .forEach { $0?.isChecked.accept(!preValue) }
            case .requiredFirst:
                viewModel.requiredFirstIsSelected.accept(!viewModel.requiredFirstIsSelected.value)
                self?.firstAgreeButton.isChecked.accept(viewModel.requiredFirstIsSelected.value)
            case .requiredSecond:
                viewModel.requiredSecondIsSelected.accept(!viewModel.requiredSecondIsSelected.value)
                self?.secondAgreeButton.isChecked.accept(viewModel.requiredSecondIsSelected.value)
            case .requiredThird:
                viewModel.requiredThirdIsSelected.accept(!viewModel.requiredThirdIsSelected.value)
                self?.thirdAgreeButton.isChecked.accept(viewModel.requiredThirdIsSelected.value)
            case .notRequiredFourth:
                viewModel.notRequiredFourthIsSelected.accept(!viewModel.notRequiredFourthIsSelected.value)
                self?.fourthAgreeButton.isChecked.accept(viewModel.notRequiredFourthIsSelected.value)
            }
        }
        .disposed(by: disposeBag)
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.snp.makeConstraints {
            $0.width.equalTo(390.0)
            $0.height.equalTo(284.0)
        }
        
        addSubviews([decorateLine1, allAgreeButton, decorateLine2, firstAgreeButton, secondAgreeButton, thirdAgreeButton, fourthAgreeButton])
        decorateLine1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        allAgreeButton.snp.makeConstraints {
            $0.top.equalTo(decorateLine1.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }
        
        decorateLine2.snp.makeConstraints {
            $0.top.equalTo(allAgreeButton.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
        }
        
        firstAgreeButton.snp.makeConstraints {
            $0.top.equalTo(decorateLine2.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        secondAgreeButton.snp.makeConstraints {
            $0.top.equalTo(firstAgreeButton.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        thirdAgreeButton.snp.makeConstraints {
            $0.top.equalTo(secondAgreeButton.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        fourthAgreeButton.snp.makeConstraints {
            $0.top.equalTo(thirdAgreeButton.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
    }
}
