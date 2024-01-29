import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

public class ExtraTableViewCell: BaseTableViewCell {

    static let identifier: String = "ExtraTableViewCell"

    private var extraCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12.0
        layout.itemSize = CGSize(width: 240, height: 240)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = DSKitAsset.Colors.gray25.color
        collectionView.register(
            ExtraCollectionViewCell.self,
            forCellWithReuseIdentifier: ExtraCollectionViewCell.identifier)
        return collectionView
    }()

    var extras: [ExtrasModel] = [] {
        didSet {
            extraCollectionView.reloadData()
        }
    }
    
    public override func attribute() {
        super.attribute()
        
        self.backgroundColor = DSKitAsset.Colors.gray25.color
        
        extraCollectionView.delegate = self
        extraCollectionView.dataSource = self
    }
    
    public override func layout() {
        super.layout()
        
        contentView.addSubview(extraCollectionView)

        extraCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ExtraTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return extras.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ExtraCollectionViewCell.identifier,
            for: indexPath
        ) as? ExtraCollectionViewCell else {
            fatalError("Unable to dequeue ExtraCollectionViewCell")
        }
        cell.configure(with: extras[indexPath.item])
        cell.layer.cornerRadius = 16.0
        return cell
    }
}

extension ExtraTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(extras[indexPath.row])
    }
}
