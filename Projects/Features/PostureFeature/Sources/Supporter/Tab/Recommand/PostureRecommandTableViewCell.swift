import UIKit

import SnapKit
import Then

import Core
import DSKit
import Domain

import RxSwift
import RxCocoa

public class PostureRecommandTableViewCell: BaseTableViewCell{

    static let identifier: String = "PostureRecommandTableViewCell"
    
    public var seemoreButtonTap: ControlEvent<Void> {
         return seemoreButton.rx.tap
    }

    private let containerView = UIView()
    private var currentTitleText: String = ""

    private var exerciseTitleLabel = MGLabel(font: UIFont.Pretendard.titleMedium,
                                             textColor: .black,
                                             isCenter: false
    )

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

    private var recommandExerciseData: [PoseRecommandResponseModel] = [] {
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
        addSubviews([containerView, exerciseCollectionView])
        containerView.addSubviews([exerciseTitleLabel, seemoreButton])

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(32.0)
        }

        exerciseTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        seemoreButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(74.0)
            $0.height.equalTo(24.0)
        }

        exerciseCollectionView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24.0)
        }
    }
}

public extension PostureRecommandTableViewCell {
    func setup(with model: [PoseRecommandResponseModel], titleText: String) {
        exerciseTitleLabel.changeText(text: "\(titleText) 운동")
        recommandExerciseData = model
        currentTitleText = titleText
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
