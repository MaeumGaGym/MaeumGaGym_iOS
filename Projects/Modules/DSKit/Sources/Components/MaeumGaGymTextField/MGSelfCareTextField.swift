import UIKit

import Then
import SnapKit

import RxSwift
import RxCocoa

import Core

open class MGSelfCareTextField: UITextField {

    private let disposeBag = DisposeBag()

    public var errorMessage = PublishRelay<String?>()

    private lazy var leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
    private lazy var rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))

    private let typeLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyMedium
    }
    private let unitLabel = UILabel().then {
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.font = UIFont.Pretendard.bodyLarge
    }

    public init(
        typeText: String,
        keyboardType: UIKeyboardType,
        unitText: String? = nil
    ) {
        super.init(frame: .zero)

        self.typeLabel.text = typeText
        self.placeholder = typeText
        self.keyboardType = keyboardType
        self.unitLabel.text = unitText

        setup()
        bind()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        setPlaceholder()
    }

    private func setup() {
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = DSKitAsset.Colors.gray25.color
        self.layer.cornerRadius = 8
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
    
    private func layout() {
        self.addSubviews([
            typeLabel,
            unitLabel
        ])

        typeLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.top).inset(-8)
            $0.leading.equalToSuperview()
        }
        unitLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }

}

extension MGSelfCareTextField {
    private func bind() {
        self.rx.controlEvent(.allEditingEvents)
            .subscribe(onNext: { [weak self] in
                self?.layer.borderColor = DSKitAsset.Colors.blue100.color.cgColor
                self?.backgroundColor = DSKitAsset.Colors.blue50.color
            }).disposed(by: disposeBag)

        self.rx.controlEvent(.editingDidEnd)
            .subscribe(
                onNext: { [weak self] in
                    self?.setup()
                }
            )
            .disposed(by: disposeBag)
    }

    private func setPlaceholder() {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [
                .foregroundColor: DSKitAsset.Colors.gray200.color,
                .font: UIFont.Pretendard.bodyLarge
            ]
        )
    }

}
