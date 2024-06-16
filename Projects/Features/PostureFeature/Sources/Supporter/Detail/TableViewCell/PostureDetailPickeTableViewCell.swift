import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class PostureDetailPickeTableViewCell: BaseTableViewCell {

    static let identifier: String = "PostureDetailPickeTableViewCell"

    private let containerView = BaseView()

    private let titleLabel = MGLabel(font: UIFont.Pretendard.titleMedium,
                                     textColor: .black,
                                     isCenter: false
    )

    private var pickleCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
        }

        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(PostureDetailPickleCollectionViewCell.self,
                        forCellWithReuseIdentifier: PostureDetailPickleCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        return collectionView
    }()

    var pickleData: [UIImage] = [] {
        didSet {
            pickleCollectionView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = .white
        pickleCollectionView.dataSource = self
        pickleCollectionView.delegate = self
    }

    public override func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([titleLabel, pickleCollectionView])
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.bottom.equalToSuperview().offset(-36.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        pickleCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12.0)
        }
    }
}

public extension PostureDetailPickeTableViewCell {
    func setup(with model: [UIImage]) {
        titleLabel.changeText(text: "관련 피클")
        pickleData = model
    }
}

extension PostureDetailPickeTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 126.0, height: 224.0)
    }
}

extension PostureDetailPickeTableViewCell: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        _ = pickleData[indexPath.row]
    }
}

extension PostureDetailPickeTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return pickleData.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostureDetailPickleCollectionViewCell.identifier,
            for: indexPath
        ) as? PostureDetailPickleCollectionViewCell
        let model = pickleData[indexPath.row]
        cell?.setup(image: model)
        return cell ?? UICollectionViewCell()
    }
}

 
