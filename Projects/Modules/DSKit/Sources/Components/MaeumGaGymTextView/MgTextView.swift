import UIKit

import Then
import SnapKit

import RxSwift
import RxCocoa

import Core

open class MGTextView: UITextView {
    
    private let disposeBag = DisposeBag()
    
    private var isEditing: Bool = false {
        didSet {
            self.attribute()
        }
    }
    
    private var bgColor: UIColor {
        isEditing ? .blue50 : .gray25
    }
    private var bdColor: CGColor {
        isEditing ? UIColor.blue100.cgColor : UIColor.gray50.cgColor
    }

    private let typeLabel = UILabel().then {
        $0.text = "내용"
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyMedium
    }
    private let placeholderLabel = UILabel().then {
        $0.text = "내용을 입력해주세요"
        $0.textColor = .gray400
        $0.font = UIFont.Pretendard.bodyLarge
        $0.isHidden = false
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        attribute()
        setup()
        bind()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    private func attribute() {
        self.backgroundColor = bgColor
        self.layer.borderColor = bdColor
    }
    private func setup() {
        self.textColor = .black
        self.font = UIFont.Pretendard.bodyLarge
        self.textContainer.maximumNumberOfLines = 0
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    private func layout() {
        self.addSubviews([
            typeLabel,
            placeholderLabel
        ])

        typeLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.top).inset(-8)
            $0.leading.equalToSuperview()
        }
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
        }
    }

}

extension MGTextView {
    private func bind() {
        self.rx.didBeginEditing
            .bind { [weak self] in
                self?.isEditing = true
            }.disposed(by: disposeBag)
        
        self.rx.didChange
            .bind { [weak self] in
                self?.placeholderLabel.isHidden = true
            }.disposed(by: disposeBag)
        
        self.rx.didEndEditing
            .bind { [weak self] in
                self?.isEditing = false

                if self?.text.isEmpty == true {
                    self?.placeholderLabel.isHidden = false
                }
            }.disposed(by: disposeBag)
    }

}
