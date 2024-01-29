import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core
import DSKit

public class RoutineTableViewCell: UITableViewCell {

    static let identifier: String = "RoutineTableViewCell"

    private var nameTitle = UILabel().then {
        $0.text = "오늘의 루틴"
        $0.textColor = .black
        $0.font = UIFont.Pretendard.titleMedium
    }

    private var routineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            RoutineCollectionCell.self,
            forCellWithReuseIdentifier: RoutineCollectionCell.identifier
        )
        return collectionView
    }()

    var routines: [RoutineModel] = [] {
        didSet {
            routineCollectionView.reloadData()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        contentView.backgroundColor = .white

        contentView.layer.cornerRadius = 16.0
        self.backgroundColor = DSKitAsset.Colors.gray25.color
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameTitle)
        contentView.addSubview(routineCollectionView)

        nameTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(28.0)
        }

        routineCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16.0)
        }

        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RoutineTableViewCell: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return routines.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoutineCollectionCell.identifier,
            for: indexPath
        ) as? RoutineCollectionCell else {
            fatalError("Unable to dequeue RoutineCollectionCell")
        }

        cell.configure(with: routines[indexPath.item])
        return cell
    }
}

extension RoutineTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 현재 이미지를 눌렀을 때만 이동하는 문제 해결해야함
        print(routines[indexPath.row])
    }
}
