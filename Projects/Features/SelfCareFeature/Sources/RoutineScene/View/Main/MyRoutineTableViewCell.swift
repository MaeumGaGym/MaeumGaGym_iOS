import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DSKit
import Domain

import MGNetworks

public class MyRoutineTableViewCell: BaseTableViewCell {

    public var dotsButtonTap: ControlEvent<Void> {
        return dotsButton.rx.tap
    }

    static let identifier: String = "MyRoutineTableViewCell"

    private var containerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.blue50.color
        $0.layer.cornerRadius = 16.0
    }

    private var routineNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.labelLarge
        $0.textColor = .black
        $0.numberOfLines = 1
    }

    private var routineStateLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodySmall
        $0.numberOfLines = 1
        $0.textColor = DSKitAsset.Colors.gray400.color
    }

    private var sharedView = MGShareStateView().then {
        $0.isHidden = true
    }

    private let dotsButton = MGImageButton(image: DSKitAsset.Assets.grayDotsActIcon.image)

    public func setup(with model: SelfCareRoutineModel) {
        routineNameLabel.text = model.routineNameText

        changeUsingState(state: model.usingState)
        changeSharingState(state: model.sharingState)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }

    override public func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([routineNameLabel, routineStateLabel, dotsButton, sharedView])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        routineNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(24.0)
        }

        routineStateLabel.snp.makeConstraints {
            $0.top.equalTo(routineNameLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(37.0)
            $0.height.equalTo(18.0)
        }

        dotsButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(29.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.width.height.equalTo(24.0)
        }

        sharedView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(23.0)
            $0.trailing.equalTo(dotsButton.snp.leading).offset(-12.0)
            $0.width.equalTo(98.0)
            $0.height.equalTo(36.0)
        }
    }
}

public extension MyRoutineTableViewCell {

    func changeRoutineName(text: String) {
        routineNameLabel.text = text
    }

    func changeSharingState(state: Bool) {
        switch state {
        case true:
            sharedView.isHidden = false
        case false:
            sharedView.isHidden = true
        }
    }

    func changeUsingState(state: Bool) {
        switch state {
        case true:
            routineStateLabel.text = "사용중"
            routineStateLabel.textColor = DSKitAsset.Colors.blue500.color
        case false:
            routineStateLabel.text = "보관중"
            routineStateLabel.textColor = DSKitAsset.Colors.gray400.color
        }
    }
}
