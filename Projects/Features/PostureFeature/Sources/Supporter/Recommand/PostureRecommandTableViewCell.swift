import UIKit

import SnapKit
import Then

import Core
import DSKit
import Domain

public class PostureRecommandTableViewCell: BaseTableViewCell{
    static let identifier: String = "PostureRecommandTableViewCell"

    private var titleImageLogo = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }

    private var exerciseTitleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = .black
        $0.contentMode = .left
    }

    private var seemoreButton = MaeumGaGymSeeMoreButton()

    private var exerciseCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 12
            $0.minimumInteritemSpacing = 12
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(PostureRecommandCollectionViewCell.self,
                        forCellWithReuseIdentifier: PostureRecommandCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
        }
        return collectionView
    }()

    private var recommandExerciseData: [PostureRecommandExerciseModel] = [] {
        didSet {
            exerciseCollectionView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        backgroundColor = .white
        exerciseCollectionView.delegate = self
        exerciseCollectionView.dataSource = self
    }

    public override func layout() {
        addSubviews([titleImageLogo, exerciseTitleLabel, seemoreButton, exerciseCollectionView])

        titleImageLogo.snp.makeConstraints {
            $0.width.height.equalTo(40.0)
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        exerciseTitleLabel.snp.makeConstraints {
            $0.width.equalTo(89.0)
            $0.height.equalTo(32)
            $0.top.equalTo(titleImageLogo.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        seemoreButton.snp.makeConstraints {
            $0.width.equalTo(74.0)
            $0.height.equalTo(24.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.top.equalToSuperview().offset(28.0)
        }

        exerciseCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(200.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }

    public func selecCell(model: PostureRecommandModel) {
        titleImageLogo.image = model.titleImage
        exerciseTitleLabel.text = model.titleText
        recommandExerciseData = model.exerciseData
    }
}

extension PostureRecommandTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 148.0, height: 200.0)
    }
}

extension PostureRecommandTableViewCell: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        _ = recommandExerciseData[indexPath.row]
    }
}

extension PostureRecommandTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return recommandExerciseData.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostureRecommandCollectionViewCell.identifier,
            for: indexPath
        ) as? PostureRecommandCollectionViewCell
        let model = recommandExerciseData[indexPath.row]
        cell?.setup(with: model)
        return cell ?? UICollectionViewCell()
    }
}
