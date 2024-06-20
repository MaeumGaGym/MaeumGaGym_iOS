import UIKit
import Data

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

import Domain
import MGNetworks

public class SelfCareMenuTableViewCell: BaseTableViewCell {
    
    public var cellState: (() -> Void)?

    static let identifier: String = "SelfCareMenuTableViewCell"

    private var nameTitle = MGLabel(
        text: "자기관리",
        font: UIFont.Pretendard.titleMedium,
        textColor: .black
    )

    private lazy var collectoinViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 8.0
        $0.itemSize.width = self.frame.width
    }
    private lazy var selfCareMenuCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectoinViewFlowLayout
    ).then {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.register(
            SelfCareMenuCollectionCell.self,
            forCellWithReuseIdentifier: SelfCareMenuCollectionCell.identifier
        )
    }

    var menus: [SelfCareMenuModel] = [] {
        didSet {
            selfCareMenuCollectionView.reloadData()
        }
    }
    
//    public init(
//        cellState: @escaping () -> Void
//    ) {
//        self.cellState = cellState
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public override func attribute() {
        super.attribute()

        self.backgroundColor = DSKitAsset.Colors.gray25.color
        selfCareMenuCollectionView.delegate = self
        selfCareMenuCollectionView.dataSource = self
    }

    public override func layout() {
        super.layout()

        setupCornerRadiusAndBackground()
        contentView.addSubviews([nameTitle, selfCareMenuCollectionView])

        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        selfCareMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}

extension SelfCareMenuTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return menus.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelfCareMenuCollectionCell.identifier,
            for: indexPath
        ) as? SelfCareMenuCollectionCell else {
            fatalError("Unable to dequeue SelfCareMenuCollectionCell")
        }

        cell.configure(with: menus[indexPath.item])
        cell.frame.size.width = self.frame.width

        return cell
    }
}

extension SelfCareMenuTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(menus[indexPath.row])
        switch indexPath.row {
        case 1:
            self.cellState!()
            return
        default:
            return
        }
    }
}
