import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import DSKit
import Core

public class TimerEditView: BaseView {

    private var backView = UIView()

    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16.0
        $0.layer.shadow(color: DSKitAsset.Colors.gray50.color, alpha: 0.3, x: 0, y: 0, blur: 0, spread: 0)
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 6
    }

    private var firstButton = MGButton(
        titleText: "타이머 편집",
        font: UIFont.Pretendard.labelMedium,
        textColor: .black
    ).then {
        $0.contentHorizontalAlignment = .left
    }

    private var secondButton = MGButton(
        titleText: "설정",
        font: UIFont.Pretendard.labelMedium,
        textColor: .black
    ).then {
        $0.contentHorizontalAlignment = .left
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func attribute() {
        layer.cornerRadius = 16.0
    }

    public override func layout() {
        addSubview(backView)
        backView.addSubview(containerView)
        containerView.addSubviews([firstButton, secondButton])

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.0)
            $0.trailing.equalToSuperview().offset(-24.0)
            $0.width.equalTo(130.0)
            $0.height.equalTo(80.0)
        }

        firstButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.height.equalTo(40.0)
            $0.trailing.equalToSuperview()
        }

        secondButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.height.equalTo(40.0)
            $0.trailing.equalToSuperview()

        }

        let tapBackView = UITapGestureRecognizer(target: self, action: #selector(handleTapBackView))
        backView.addGestureRecognizer(tapBackView)
    }

    public func showView() {
        print("showView called")
        self.isHidden = false
        self.superview?.bringSubviewToFront(self)
    }

    public func hideView() {
        self.isHidden = true
        self.superview?.sendSubviewToBack(self)
    }

    @objc private func handleTapBackView(sender: UITapGestureRecognizer) {
        self.hideView()
    }
}
