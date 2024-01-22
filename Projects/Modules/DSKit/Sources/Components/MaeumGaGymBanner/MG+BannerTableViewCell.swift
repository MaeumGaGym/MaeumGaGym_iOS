import Foundation
import UIKit
import RxRelay
import RxSwift
import RxCocoa

public class MGBannerTableViewCell: UITableViewCell {
    
    static public var identifier: String = "MonsterBannerTableViewCell"
    
    private var bannerAutoScrollTimer: Timer?
    
    public let disposeBag = DisposeBag()
    private var timerDisposeBag = DisposeBag()
    
    private var bannerModel: MGBannerModel?
    public var imageList: [UIImage] = [
        DSKitAsset.Assets.testImage1.image,
        DSKitAsset.Assets.testImage1.image,
        DSKitAsset.Assets.testImage1.image,
        DSKitAsset.Assets.testImage1.image,
        DSKitAsset.Assets.testImage1.image
    ]
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MGBannerCell.self,
                                forCellWithReuseIdentifier: MGBannerCell.identifier)
        return collectionView
    }()
    
    private lazy var indicatorView: MGIndicatorView = {
        guard let viewModel = bannerModel else { return MGIndicatorView(viewModel: bannerModel!) }
        let indicatorView = MGIndicatorView(viewModel: viewModel)
        return indicatorView
    }()
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.entryCollectionItem()
        self.bindWidthRatio(
            self.collectionView.contentSize.width,
            self.collectionView.contentInset.left,
            self.collectionView.contentInset.right,
            self.collectionView.bounds.width,
            self.imageList.count
        )
        self.bannerTimer()
    }
    
    public func setUp(_ model: MGBannerModel) {
        self.bannerModel = model
        self.layout()
        self.imageList.insert(self.imageList[self.imageList.count - 1], at: 0)
        self.imageList.append(imageList[1])
        self.imageList.insert(self.imageList[self.imageList.count - 3], at: 0)
        self.imageList.append(imageList[3])
    }
    
    private func layout() {
        [
            collectionView,
            indicatorView
        ].forEach { self.contentView.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(4)
        }
    }
    
    private func setupImages() {
        guard let viewModel = bannerModel else { return }
        imageList = viewModel.imageList
        collectionView.reloadData()
        
        if imageList.count > 0 {
            let indexPath = IndexPath(item: 2, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        indicatorView.viewModel = viewModel
    }
}

extension MGBannerTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("adsf")
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = bannerModel else {return}
        viewModel.computeLeftOffsetRation(
            scrollView.contentSize.width,
            scrollView.contentOffset.x,
            scrollView.contentInset.left,
            scrollView.contentInset.right,
            self.imageList.count
        )
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentIndex = computeCurrentIndex()
        var indexPath: IndexPath?
        if currentIndex == self.imageList.endIndex - 1 {
            indexPath = IndexPath(item: 3, section: 0)
        } else if currentIndex == self.imageList.endIndex - 2 {
            indexPath = IndexPath(item: 2, section: 0)
        } else if currentIndex == 1 {
            indexPath = IndexPath(item: self.imageList.endIndex - 3, section: 0)
        } else if currentIndex == 0 {
            indexPath = IndexPath(item: self.imageList.endIndex - 4, section: 0)
        }
        guard let indexPath = indexPath else { return }
        self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
}

extension MGBannerTableViewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MGBannerCell.identifier,
            for: indexPath
        ) as? MGBannerCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: imageList[indexPath.item])
        return cell
    }
}

extension MGBannerTableViewCell {
    
    private func bindWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double,
        _ numberOfData: Int
    ) {
        guard let homeViewModel = self.bannerModel else {return}
        homeViewModel.computeWidthRatio(
            contentSizeWidth,
            contentInsetLeft,
            contentInsetRight,
            showingWidth,
            numberOfData
        )
        
        self.indicatorView.layoutIfNeeded()
    }
    
    private func entryCollectionItem() {
        let indexPath = IndexPath(item: 2, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
    
    func computeCurrentIndex() -> Int {
        let visibleIndexPaths = self.collectionView.indexPathsForVisibleItems
        guard let currentVisibleIndexPath = visibleIndexPaths.first else { return 0 }
        let currentIndex = currentVisibleIndexPath.item
        return currentIndex
    }
    
    public func bannerTimer() {
        Observable<Int>.timer(.seconds(5), period: .seconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.bannerMove()
            })
            .disposed(by: timerDisposeBag)
    }

    public func bannerMove() {
        let currentIndex = self.computeCurrentIndex()
        var indexPath: IndexPath?
        if currentIndex == self.imageList.endIndex - 3 {
            indexPath = IndexPath(item: 2, section: 0)
        } else {
            indexPath = IndexPath(item: currentIndex + 1, section: 0)
        }
        guard let indexPath = indexPath else {return}
        self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    public func bannerStop() {
        bannerAutoScrollTimer?.invalidate()
        bannerAutoScrollTimer = nil
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        bannerAutoScrollTimer?.invalidate()
        bannerAutoScrollTimer = nil
        timerDisposeBag = DisposeBag()
    }
    
    public func bannerMoveToFirst() {
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}
