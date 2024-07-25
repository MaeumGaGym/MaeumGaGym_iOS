import UIKit

import Then
import SnapKit

import RxSwift
import RxCocoa

import Core

open class MGTextView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private var isEditing: Bool = false {
        didSet {
            self.attribute()
        }
    }
    
    private var labelColor: UIColor {
        isEditing ? .blue500 : .black
    }
    private var bgColor: UIColor {
        isEditing ? .blue50 : .gray25
    }
    private var bdColor: CGColor {
        isEditing ? UIColor.blue100.cgColor : UIColor.gray50.cgColor
    }

    public let textView = UITextView().then {
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textContainer.maximumNumberOfLines = 0
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    private let typeLabel = UILabel().then {
        $0.text = "내용"
        $0.font = UIFont.Pretendard.bodyMedium
    }
    private let placeholderLabel = UILabel().then {
        $0.text = "내용을 입력해주세요"
        $0.textColor = .gray400
        $0.font = UIFont.Pretendard.bodyLarge
        $0.isHidden = false
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
//        setup()
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
        self.typeLabel.textColor = labelColor
        self.textView.backgroundColor = bgColor
        self.textView.layer.borderColor = bdColor
    }
//    private func setup() {
//        $0.textColor = .black
//        $0.font = UIFont.Pretendard.bodyLarge
//        $0.textContainer.maximumNumberOfLines = 0
//        $0.layer.cornerRadius = 8
//        $0.layer.borderWidth = 1
//        $0.autocorrectionType = .no
//        $0.autocapitalizationType = .none
//        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//    }
    private func layout() {
        self.addSubviews([
            typeLabel,
            textView
        ])
        
        textView.addSubview(placeholderLabel)
//
//        self.snp.makeConstraints {
//            $0.height.equalTo(228)
//        }
        typeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
        }
    }

}

extension MGTextView {
    private func bind() {
        self.textView.rx.didBeginEditing
            .bind { [weak self] in
                self?.isEditing = true
            }.disposed(by: disposeBag)
        
        self.textView.rx.didChange
            .bind { [weak self] in
                self?.placeholderLabel.isHidden = true
            }.disposed(by: disposeBag)
        
        self.textView.rx.didEndEditing
            .bind { [weak self] in
                self?.isEditing = false

                if self?.textView.text.isEmpty == true {
                    self?.placeholderLabel.isHidden = false
                }
            }.disposed(by: disposeBag)
    }

}
