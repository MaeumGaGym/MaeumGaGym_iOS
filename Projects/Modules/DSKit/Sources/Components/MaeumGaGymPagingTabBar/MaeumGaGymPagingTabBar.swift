import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

public class MaeumGaGymPagingTabBar: UIView {
    
    public var cellHeight: CGFloat { 36.0 }

    private var categoryTitleList: [String]
    
    public let selectedIndex = PublishSubject<Int>()
        
    public let itemSelected = PublishSubject<IndexPath>()
    
    private let disposeBag = DisposeBag()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let inset: CGFloat = 0.0
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - inset * 2) / CGFloat(min(categoryTitleList.count, 7))
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        
        collectionView.register(MaeumGaGymPagingTabBarCell.self,
                                forCellWithReuseIdentifier:
                                    MaeumGaGymPagingTabBarCell.identifier)
        
        collectionView.isScrollEnabled = categoryTitleList.count >= 7
        
         Observable.just(categoryTitleList).bind(to:
            collectionView.rx.items(cellIdentifier:
                                        MaeumGaGymPagingTabBarCell.identifier,
                cellType:MaeumGaGymPagingTabBarCell.self)) { (row,title,
                    cell) in
                
                cell.setupView(title:title)
                
            }.disposed(by: disposeBag)

         collectionView.rx.itemSelected.bind(to:self.itemSelected).disposed(by:self.disposeBag)

         return collectionView
         
    }()
    
    public init(categoryTitleList:[String]) {
       self.categoryTitleList = categoryTitleList;
       super.init(frame:.zero);
       setupLayout();
       
       self.collectionView.selectItem(at:
           IndexPath(row : 0 , section : 0),
           animated:true,
           scrollPosition:[]
       )
        
        collectionView.rx.itemSelected.subscribe(onNext:{[weak self] indexPath in
          guard let strongSelf=self else { return }
          strongSelf.selectedIndex.onNext(indexPath.row)
        }).disposed(by:self.disposeBag)
       
   }
   
   required init?(coder:NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
    
}

extension MaeumGaGymPagingTabBar: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension MaeumGaGymPagingTabBar: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitleList.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaeumGaGymPagingTabBarCell.identifier, for: indexPath) as? MaeumGaGymPagingTabBarCell else { return UICollectionViewCell() }
        
        cell.setupView(title: categoryTitleList[indexPath.row])
        
        return cell
    }
}

private extension MaeumGaGymPagingTabBar {
    func setupLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
