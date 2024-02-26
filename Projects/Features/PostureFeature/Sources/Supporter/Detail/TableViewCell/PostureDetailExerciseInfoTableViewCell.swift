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

    private var exerciseWay = MGLabel(text: PostureResourcesService.Title.execiseWayTitle,
                                      font: UIFont.Pretendard.titleMedium,
                                      textColor: .black,
                                      isCenter: false
    )
    
    private var detaiTextCollectionView: UICollectionView = {
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

    

    public override func layout() {
        super.layout()

        contentView.addSubviews([exerciseWay, exerciseInfo1, exerciseInfo2, exerciseInfo3])

        exerciseWay.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        exerciseInfo1.snp.makeConstraints {
            $0.top.equalTo(exerciseWay.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }

        exerciseInfo2.snp.makeConstraints {
            $0.top.equalTo(exerciseInfo1.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }

        exerciseInfo3.snp.makeConstraints {
            $0.top.equalTo(exerciseInfo2.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalToSuperview()
        }
    }
}

public extension PostureDetailExerciseInfoTableViewCell {
    func setup(model: PostureDetailInfoModel) {
        let exerciseInfos = model.informationText

        self.exerciseInfo1.updateData(textNum: "01", text: exerciseInfos[0].text)
        self.exerciseInfo2.updateData(textNum: "02", text: exerciseInfos[1].text, numberOfLines: 2)
        self.exerciseInfo3.updateData(textNum: "03", text: exerciseInfos[2].text)
    }
}
