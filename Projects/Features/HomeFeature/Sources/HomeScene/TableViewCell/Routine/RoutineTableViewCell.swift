import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain
import MGNetworks

import HomeFeatureInterface

public class RoutineTableViewCell: BaseTableViewCell, CollectoionCellID {

    public static var identifier: String = HomeResourcesService.identifier.routineTableViewCell

    private var nameTitle = MGLabel(text: HomeResourcesService.Title.todayRoutine,
                                    font: UIFont.Pretendard.titleMedium,
                                    textColor: .black
    )

    private var routineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            RoutineCollectionCell.self,
            forCellWithReuseIdentifier: RoutineCollectionCell.identifier
        )
        return collectionView
    }()

    var routines: [RoutineModel] = [] {
        didSet {
            routineCollectionView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        self.backgroundColor = DSKitAsset.Colors.gray25.color
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }

    public override func layout() {
        super.layout()

        setupCornerRadiusAndBackground()
        contentView.addSubviews([nameTitle, routineCollectionView])

        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(28.0)
        }

        routineCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}

extension RoutineTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return routines.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoutineCollectionCell.identifier,
            for: indexPath
        ) as? RoutineCollectionCell else {
            fatalError("Unable to dequeue RoutineCollectionCell")
        }

        cell.configure(with: routines[indexPath.item])
        return cell
    }
}

extension RoutineTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 현재 이미지를 눌렀을 때만 이동하는 문제 해결해야함
        print(routines[indexPath.row])
    }
}
