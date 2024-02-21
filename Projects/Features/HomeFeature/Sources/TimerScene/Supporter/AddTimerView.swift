import UIKit

import SnapKit
import Then

import Core
import DSKit

public class AddTimerView: BaseView {

    private var containerView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    private let timerAddBackView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
    }

    private let addTimerLabel = UILabel().then {
        $0.text = "타이머 추가"
        $0.font = UIFont.Pretendard.titleMedium
        $0.textAlignment = .left
        $0.textColor = .black
    }

    private let timerPickerView = TimerPickerView()

    public override func layout() {
        addSubviews([containerView])
        containerView.addSubviews([timerAddBackView])
        timerAddBackView.addSubviews([addTimerLabel, timerPickerView])

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        timerAddBackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(containerView.safeAreaLayoutGuide)
            $0.top.equalTo(containerView.snp.centerY).offset(-62.0)
        }

        addTimerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(32.0)
        }

        timerPickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().offset(80.0)
            $0.bottom.equalToSuperview().offset(-74.0)
        }
    }
}
