import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import CSLogger
import PostureFeatureInterface

public class PostureRecommandViewController: BaseViewController<PostureViewModel>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // CollectionView 선언
    var collectionView: UICollectionView!
    
    // 데이터 선언
    let firstTitleCellData = [("맨몸 운동", DSKitAsset.Assets.arm.image)]
    let firstCellData = [
        (DSKitAsset.Assets.pushUp.image, "푸시업", "가슴"),
        (DSKitAsset.Assets.reverseCrunch.image, "리버스 크런치", "복근"),
        (DSKitAsset.Assets.hollowPosition.image, "할로우 포지션", "복근")
    ]
    
    let secondTitleCellData = [("기구 운동", DSKitAsset.Assets.arm.image)]
    let secondCellData = [
        (DSKitAsset.Assets.pushUp.image, "푸시업", "가슴"),
        (DSKitAsset.Assets.reverseCrunch.image, "리버스 크런치", "복근"),
        (DSKitAsset.Assets.hollowPosition.image, "할로우 포지션", "복근")
    ]
    
    override public func layout() {
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        layout1.minimumLineSpacing = 10  // 셀 사이의 수직 간격 설정
            layout1.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(PostureRecommandCollectionViewCell.self, forCellWithReuseIdentifier: PostureRecommandCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        // CollectionView 추가
        view.addSubview(collectionView)
        
        // CollectionView constraints 설정
        collectionView.snp.makeConstraints {
            $0.width.equalTo(430.0)
            $0.height.equalTo(676.0)
            $0.center.equalToSuperview()
        }
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return firstCellData.count
        case 1:
            return secondCellData.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostureRecommandCollectionViewCell.identifier, for: indexPath) as? PostureRecommandCollectionViewCell else {
            fatalError("Cannot create PostureRecommandCollectionViewCell")
        }

        switch indexPath.section {
        case 0:
            let data = firstCellData[indexPath.row]
            cell.configure(titleData: firstTitleCellData[0], cellData: [data])
        case 1:
            let data = secondCellData[indexPath.row]
            cell.configure(titleData: secondTitleCellData[0], cellData: [data])
        default:
            break
        }

        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 430, height: 340)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


