import UIKit

import RxCocoa
import RxSwift

import SnapKit
import Then

import Core

open class MGSearchView: BaseView {

    private var searchImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = DSKitAsset.Assets.blackSearchActIcon.image
    }

    public let searchTextField = UITextField().then {
        $0.tintColor = DSKitAsset.Colors.gray300.color
        $0.placeholder = "자세 검색"
    }

    private var cancelButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.blackCancel.image, for: .normal)
        $0.isHidden = true
    }

    public init () {
        super.init(frame: .zero)
        bind()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func attribute() {
        super.attribute()

        self.backgroundColor = DSKitAsset.Colors.gray50.color
        self.layer.cornerRadius = 8.0
    }

    public override func layout() {
        addSubviews([searchImage, searchTextField, cancelButton])

        searchImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(24.0)
        }

        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10.0)
            $0.leading.equalTo(searchImage.snp.trailing).offset(8.0)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-8.0)
            $0.height.equalTo(40.0)
        }

        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12.0)
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(24.0)
        }
    }

    private func bind() {
        searchTextField.rx.text.orEmpty
            .map { $0.isEmpty }
            .bind(to: cancelButton.rx.isHidden)
            .disposed(by: disposeBag)

        cancelButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.searchTextField.text = ""
        }).disposed(by: disposeBag)
    }
}

public extension MGSearchView {
    func hideCancelButton() {
        self.cancelButton.isHidden = true
    }

    func showCancelButton() {
        self.cancelButton.isHidden = true
    }
}
