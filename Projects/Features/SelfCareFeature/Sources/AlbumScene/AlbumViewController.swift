import UIKit

import SnapKit
import Then

import MGNetworks
import Domain

import Core

import Photos
import SelfCareFeatureInterface

final public class AlbumViewController: BaseViewController<Any> {

    private lazy var navBar = AlbumNavigationBar()

    private enum Const {
        static let numberOfColumns = 3.0
        static let cellSpace = 1.0
        static let length = (UIScreen.main.bounds.size.width - cellSpace * (numberOfColumns - 1)) / numberOfColumns
        static let cellSize = CGSize(width: length, height: length)
        static let scale = UIScreen.main.scale
    }

    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = Const.cellSpace
        $0.minimumInteritemSpacing = Const.cellSpace
        $0.itemSize = Const.cellSize
    }

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var albums: [AlbumInfo]
    private var currentAlbumIndex = 1 {
        didSet {
            PhotoService.shared.getPHAssets(album: self.albums[self.currentAlbumIndex].album) { [weak self] phAssets in
                self?.phAssets = phAssets
            }
        }
    }

    private var currentAlbum: PHFetchResult<PHAsset>? {
        guard self.currentAlbumIndex <= self.albums.count - 1 else { return nil }
        return self.albums[self.currentAlbumIndex].album
    }

    private var phAssets = [PHAsset]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    public init(albums: [AlbumInfo]) {
        self.albums = albums

        super.init((Any).self)

        PhotoService.shared.getPHAssets(album: albums[currentAlbumIndex].album) { [weak self] phAssets in
            self?.phAssets = phAssets
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func layout() {
        super.layout()
        view.addSubviews([navBar, collectionView])

        navBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    public override func attribute() {
        super.attribute()

        view.backgroundColor = .black
        PhotoService.shared.delegate = self
        collectionView.dataSource = self
    }
}

extension AlbumViewController: PHPhotoLibraryChangeObserver {
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("바뀌었다")
    }
}

extension AlbumViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int
    ) -> Int {
        self.phAssets.count
    }
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.id,
                                                    for: indexPath
            ) as? AlbumCell
        else { fatalError() }

        PhotoService.shared.fetchImage(
            asset: self.phAssets[indexPath.item],
            size: .init(width: Const.length * Const.scale, height: Const.length * Const.scale),
            contentMode: .aspectFit
        ) { [weak cell] image in
            DispatchQueue.main.async {
                cell?.prepare(image: image)
            }
        }

        return cell
    }
}
