import UIKit
import RxSwift
import RxCocoa

public class DSEmptyViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    public let disposeBag = DisposeBag()
    
    private let items = BehaviorSubject(value: Array(repeating: "King_of_the_junha", count: 0))
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TestCollectionViewCell.self,
                                forCellWithReuseIdentifier: "TestCollectionViewCell")
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        items.subscribe(onNext: { [weak self] items in
            if items.isEmpty {
                self?.collectionView.setEmptyMessage("아직 게시물이 없어요.",
                                                     image: UIImage(systemName: "square.and.arrow.up.fill")!)
            } else {
                self?.collectionView.restore()
            }
        }).disposed(by: disposeBag)
        
        setupBinding()
    }
    
    public func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.collectionView.delegate = self
    }
    
    private func setupBinding() {
        
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            
            print(indexPath.row)
            
        }).disposed(by: disposeBag)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: 80)
        return size
    }
}
