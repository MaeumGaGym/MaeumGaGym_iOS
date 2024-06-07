import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class PostureDetailTableViewCell: BaseTableViewCell {
    
    static let identifier: String = "PostureDetailTableViewCell"
    
    private var containerView = BaseView()

    private var titleLabel = MGLabel(
        font: UIFont.Pretendard.titleMedium, 
        isCenter: false
    )
    
    private var contentsLabel = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
        isCenter: false,
        numberOfLineCount: 3
    )
    
    private var detailTextCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(PostureDetailTextCollectionViewCell.self,
                        forCellWithReuseIdentifier: PostureDetailTextCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.isScrollEnabled = false
        }
        return collectionView
    }()
    
    private var detailTextModel: [PostureDetailInfoTextModel] = [] {
        didSet {
            detailTextCollectionView.reloadData()
        }
    }
    
    public override func layout() {
        addSubviews([containerView])
        containerView.addSubviews([titleLabel, contentsLabel, detailTextCollectionView])
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.centerX.bottom.equalToSuperview()
            $0.width.equalToSuperview().inset(20.0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        detailTextCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    public override func attribute() {
        super.attribute()
        
        detailTextCollectionView.delegate = self
        detailTextCollectionView.dataSource = self
    }
}

public extension PostureDetailTableViewCell {
    func setup(with model: PostureDetailInfoModel) {
        switch model.infoText.count {
        case 1:
            contentsLabel.changeText(text: "\(model.infoText[0].text)")
            detailTextCollectionView.isHidden = true
            contentsLabel.isHidden = false
        default:
            detailTextModel = model.infoText
            detailTextCollectionView.isHidden = false
            contentsLabel.isHidden = true
        }
        titleLabel.changeText(text: model.titleText)
    }
}

extension PostureDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let lineCount = detailTextModel[indexPath.row].text.components(separatedBy: "\n").count - 1

        return CGSize(width: self.frame.width, height: 32.0 + (CGFloat(lineCount) * 20.0))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension PostureDetailTableViewCell: UICollectionViewDataSource {
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

