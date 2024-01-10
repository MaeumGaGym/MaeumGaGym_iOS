import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

public class PagingTabBarViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let categoryTitleList = ["추천", "맨몸", "기구", "가슴", "등", "어깨", "팔", "복근", "앞 허벅지"]
    
    private lazy var pagingTabBar = MaeumGaGymPagingTabBar(categoryTitleList: categoryTitleList)
    
    private lazy var viewControllers: [UIViewController] = [
        RedViewController(),
        GreenViewController(),
        BlueViewController(),
        BlackViewController()
     ]
     
     private lazy var containerView: UIView = {
         let view = UIView()
         return view
     }()
     
     private var currentVC: UIViewController?
     
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bindEvents()
        attribute()
        pagingTabBar.selectedIndex.onNext(0)
    }
    
    func attribute() {
        view.backgroundColor = .white
    }
    
    func layout() {
       [
            pagingTabBar,
            containerView
       ].forEach { view.addSubview($0) }
       
       pagingTabBar.snp.makeConstraints {
           $0.top.equalTo(view.safeAreaLayoutGuide)
           $0.leading.trailing.equalToSuperview()
           $0.height.equalTo(pagingTabBar.cellHeight)
       }
       
       containerView.snp.makeConstraints {
           $0.top.equalTo(pagingTabBar.snp.bottom)
           $0.leading.trailing.bottom.equalToSuperview()
       }
   }

   func bindEvents() {
       pagingTabBar.selectedIndex.subscribe(onNext: { [weak self] index in
          guard let self = self else { return }

          if let currentVC = self.currentVC {
              currentVC.willMove(toParent: nil)
              currentVC.view.removeFromSuperview()
              currentVC.removeFromParent()
          }

          let vcToAdd = self.viewControllers[index]
          
          self.addChild(vcToAdd)

          vcToAdd.view.frame = self.containerView.bounds

          self.containerView.addSubview(vcToAdd.view)

          vcToAdd.didMove(toParent: self)

      }).disposed(by: self.disposeBag)
   }
}
