import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks

public class PostureDetailExerciseInfoTableViewCell: BaseTableViewCell {

    static let identifier: String = PostureResourcesService.Identifier.postureDetailExerciseInfoTableViewCell

    private var containerView = BaseView()

    private var titleLabel = MGLabel(font: UIFont.Pretendard.titleMedium,
                                      textColor: .black,
                                      isCenter: false
    )

    private var detailTextCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(PostureDetailTextCollectionViewCell.self,
                        forCellWithReuseIdentifier: PostureDetailTextCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        return collectionView
    }()

    private var detailTextModel: [PostureDetailInfoTextModel] = [] {
        didSet {
            detailTextCollectionView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = .white
        detailTextCollectionView.delegate = self
        detailTextCollectionView.dataSource = self
    }

    public override func layout() {
        super.layout()

        contentView.addSubviews([containerView])
        containerView.addSubviews([titleLabel, detailTextCollectionView])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.trailing.leading.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        detailTextCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

public extension PostureDetailExerciseInfoTableViewCell {
    func setup(with model: PostureDetailInfoModel) {
        detailTextModel = model.infoText
        titleLabel.changeText(text: model.titleText)
    }
}

extension PostureDetailExerciseInfoTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let lineCount = detailTextModel[indexPath.row].text.components(separatedBy: "\n").count - 1

        return CGSize(width: detailTextCollectionView.frame.width, height: 32.0 + (CGFloat(lineCount) * 20.0))
    }
}

extension PostureDetailExerciseInfoTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return detailTextModel.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostureDetailTextCollectionViewCell.identifier,
            for: indexPath
        ) as? PostureDetailTextCollectionViewCell
        let model = detailTextModel
        cell?.setup(index: indexPath.row + 1, with: model)
        return cell ?? UICollectionViewCell()
    }
}
