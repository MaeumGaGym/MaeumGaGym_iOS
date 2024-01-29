import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

public class ExtraTableViewCell: UITableViewCell {

    static let identifier: String = "ExtraTableViewCell"

    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    private var extraCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12.0
        layout.itemSize = CGSize(width: 240, height: 240)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(extraCollectionView)

        extraCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        extraCollectionView.delegate = self
        extraCollectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        contentView.backgroundColor = .white

        contentView.layer.cornerRadius = 16.0
        self.backgroundColor = DSKitAsset.Colors.gray25.color
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
