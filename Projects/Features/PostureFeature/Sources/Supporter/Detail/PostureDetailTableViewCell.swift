import UIKit

import SnapKit
import Then

import DSKit
import Core
import Domain

public class PostureDetailTableViewCell: BaseTableViewCell {
    
    static let identifier: String = "PostureDetailTableViewCell"

    private var titleLabel = MGLabel(
        font: UIFont.Pretendard.titleMedium, 
        isCenter: false
    )
    
    private var contentsLabel = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
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
        addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
    }
    
    public override func attribute() {
        super.attribute()
        
        detailTextCollectionView.delegate = self
        detailTextCollectionView.dataSource = self
    }
    
    private func setLayout(dataCount: Int) {
        switch dataCount {
        case 1:
            addSubviews([contentsLabel])

            contentsLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview().inset(12)
            }
        default:
            addSubviews([detailTextCollectionView])

            detailTextCollectionView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(24)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview().inset(12)
            }
        }
    }
}

public extension PostureDetailTableViewCell {
    func setup(with model: PostureDetailInfoModel) {
        switch model.infoText.count {
        case 1:
            setLayout(dataCount: 1)
            contentsLabel.changeText(text: "\(model.infoText[0].text)")
        default:
            setLayout(dataCount: 0)
            detailTextModel = model.infoText
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

        return CGSize(width: detailTextCollectionView.frame.width, height: 32.0 + (CGFloat(lineCount) * 20.0))
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

