import UIKit
import Data

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain
import MGNetworks

public class SelfCareMenuTableViewCell: BaseTableViewCell {

    static let identifier: String = "SelfCareMenuTableViewCell"

    private var nameTitle = MGLabel(text: "자기관리",
                                    font: UIFont.Pretendard.titleMedium,
                                    textColor: .black
    )

    private var selfCareMenuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            SelfCareMenuCollectionCell.self,
            forCellWithReuseIdentifier: SelfCareMenuCollectionCell.identifier
        )
        return collectionView
    }()

    var menus: [SelfCareMenuModel] = [] {
        didSet {
            selfCareMenuCollectionView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        self.backgroundColor = DSKitAsset.Colors.gray25.color
        selfCareMenuCollectionView.delegate = self
        selfCareMenuCollectionView.dataSource = self
    }

    public override func layout() {
        super.layout()

        setupCornerRadiusAndBackground()
        contentView.addSubviews([nameTitle, selfCareMenuCollectionView])

        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        selfCareMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}

extension SelfCareMenuTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return menus.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelfCareMenuCollectionCell.identifier,
            for: indexPath
        ) as? SelfCareMenuCollectionCell else {
            fatalError("Unable to dequeue SelfCareMenuCollectionCell")
        }

        cell.configure(with: menus[indexPath.item])
        return cell
    }
}

extension SelfCareMenuTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 현재 이미지를 눌렀을 때만 이동하는 문제 해결해야함
        print(menus[indexPath.row])
    }
}
