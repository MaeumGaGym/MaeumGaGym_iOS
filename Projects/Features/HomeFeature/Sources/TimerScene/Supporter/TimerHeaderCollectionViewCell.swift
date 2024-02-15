import UIKit

import SnapKit
import Then

import DSKit
import Core

public class TimerHeaderCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "TimerHeaderCollectionViewCell"

    private var containerView = UIView().then {
        $0.backgroundColor = .white
    }

    public func setup() {
        layout()
    }

    private func layout() {
       addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
