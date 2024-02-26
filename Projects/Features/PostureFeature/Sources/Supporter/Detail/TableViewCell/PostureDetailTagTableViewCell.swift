import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks

public class PostureDetailTagTableViewCell: BaseTableViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureDetailTagTableViewCell

    private var containerView = BaseView()

    private var detailTagCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 10
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(PostureDetailTagCollectionViewCell.self,
                        forCellWithReuseIdentifier: PostureDetailTagCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        return collectionView
    }()

    private var postureDetailTagModel: [PostureDetailExerciseKindModel] = [] {
        didSet {
            detailTagCollectionView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = .white
        detailTagCollectionView.delegate = self
        detailTagCollectionView.dataSource = self
    }

    public override func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([detailTagCollectionView])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }

        detailTagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension PostureDetailTagTableViewCell {
    func setup(with model: [PostureDetailExerciseKindModel]) {
        postureDetailTagModel = model
    }
}

extension PostureDetailTagTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 60.0, height: 36.0)
    }
}

extension PostureDetailTagTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return postureDetailTagModel.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostureDetailTagCollectionViewCell.identifier,
            for: indexPath
        ) as? PostureDetailTagCollectionViewCell
        let model = postureDetailTagModel[indexPath.row]
        cell?.setup(with: model)
        return cell ?? UICollectionViewCell()
    }
}

