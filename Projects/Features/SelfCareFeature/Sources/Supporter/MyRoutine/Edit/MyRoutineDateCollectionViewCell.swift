import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGNetworks

public class MyRoutineDateCollectionViewCell: UICollectionViewCell {
    static let identifier: String = SelfCareResourcesService.identifier.myRoutineDateCollectionViewCell
    
    private var disposeBag = DisposeBag()

    private var dateState: Bool = false
    
    private var containerButton = BaseButton()

    private var dateLabel = MGLabel(font: UIFont.Pretendard.bodyMedium,
                                    textColor: .black,
                                    isCenter: true,
                                    numberOfLineCount: 1
    )

    private func attribute() {
        containerButton.setColor(backColor:DSKitAsset.Colors.gray50.color )
        containerButton.setCornerRadius(radius: 8.0)
    }

    private func layout() {
        contentView.addSubviews([containerButton])
        containerButton.addSubviews([dateLabel])

        containerButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        dateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(20)
            $0.height.equalTo(14)
        }
    }
}

public extension MyRoutineDateCollectionViewCell {
    func setup(with date: String) {
//        dateLabel.text = date
        dateLabel.changeText(text: date)
        attribute()
        layout()
        buttonBind()
    }

    func setDateState() {
        containerButton.setColor(backColor:DSKitAsset.Colors.blue500.color )
        dateLabel.changeTextColor(color: .white)
        dateState = true
    }

    func buttonBind() {
        containerButton.rx.tap.subscribe(onNext: { _ in
            switch self.dateState {
            case false:
                self.containerButton.setColor(backColor:DSKitAsset.Colors.blue500.color)
                self.dateLabel.changeTextColor(color: .white)
                self.dateState = true
            case true:
                self.containerButton.setColor(backColor:DSKitAsset.Colors.gray50.color)
                self.dateLabel.changeTextColor(color: .black)
                self.dateState = false
            }
        }).disposed(by: disposeBag)
    }
}
