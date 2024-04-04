import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGNetworks

public class MyRoutineDateTableViewCell: BaseTableViewCell {
    static let identifier: String = SelfCareResourcesService.identifier.myRoutineDateTableViewCell
    
    private let date: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private var dummyDate: [String] = ["TUESDAY", "THURSDAY"]
    
    private var containerView = UIView()
    
    private var dateLabel = MGLabel(text: "요일", font: UIFont.Pretendard.bodyMedium, textColor: .black)

    private var dateCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(MyRoutineDateCollectionViewCell.self, forCellWithReuseIdentifier: MyRoutineDateCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        return collectionView
    }()
    
    public override func attribute() {
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
    }
    
    public override func layout() {
        contentView.addSubviews([containerView])
        containerView.addSubviews([dateLabel, dateCollectionView])
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(32.0)
            $0.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(28)
            $0.height.equalTo(20)
        }
        
        dateCollectionView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MyRoutineDateTableViewCell: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 52.29, height: 44.0)
    }
}

extension MyRoutineDateTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return date.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyRoutineDateCollectionViewCell.identifier,
            for: indexPath
        ) as? MyRoutineDateCollectionViewCell
        let model = date[indexPath.row]
        cell?.setup(with: model)
        let englishToKoreanDayIndex: [String: Int] = [
            "SUNDAY": 0,
            "MONDAY": 1,
            "TUESDAY": 2,
            "WEDNESDAY": 3,
            "THURSDAY": 4,
            "FRIDAY": 5,
            "SATURDAY": 6
        ]

        for englishDay in dummyDate {
            if let dayIndex = englishToKoreanDayIndex[englishDay], dayIndex == indexPath.row {
                cell?.setDateState()
                break
            }
        }
        return cell ?? UICollectionViewCell()
    }
}
