import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class MyRoutineDetailTitleView: BaseView {

    private var containerView = UIView()

    private let myRoutineTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.contentMode = .left
        $0.font = UIFont.Pretendard.titleLarge
    }

    private var routineStateLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.blue500.color
    }

    private var sharedView = MGShareStateView()

    public override func attribute() {
        sharedView.changeView(backColor: DSKitAsset.Colors.blue50.color)
    }

    public override func layout() {
        super.layout()

        addSubviews([containerView])
        containerView.addSubviews([myRoutineTitleLabel, routineStateLabel, sharedView])

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        myRoutineTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(48.0)
        }

        routineStateLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(20.0)
        }

        sharedView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.width.equalTo(98.0)
            $0.height.equalTo(36.0)
        }
    }
}

public extension MyRoutineDetailTitleView {
    func setup(with model: SelfCareRoutineModel) {
        changeTitleText(text: model.routineNameText)
        changeUsingState(state: model.usingState)
        changeSharingState(state: model.sharingState)
    }
}

private extension MyRoutineDetailTitleView {
    func changeTitleText(text: String) {
        myRoutineTitleLabel.text = text
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

    func changeSharingState(state: Bool) {
        switch state {
        case true:
            sharedView.isHidden = false
        case false:
            sharedView.isHidden = true
        }
    }
}
