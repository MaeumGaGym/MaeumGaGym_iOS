import UIKit

import RxCocoa
import RxSwift

import SnapKit
import Then

import DSKit
import Core
import Domain

import Data
import MGNetworks

public class PostureMainViewController: BaseViewController<PostureMainViewModel> {

    private let categoryTitleList = ["추천", "가슴", "등", "어깨", "팔", "복근", "앞 허벅지"]

    private let titleText = UILabel().then {
        $0.text = "자세"
        $0.textColor = .black
        $0.font = UIFont.Pretendard.titleLarge
        $0.textAlignment = .left
    }

    private lazy var pagingTabBar = MGPagingTabBar(categoryTitleList: categoryTitleList)

    lazy var recommandUseCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
    lazy var recommandViewModel = PostureRecommandViewModel(useCase: recommandUseCase)
    lazy var recommandViewController = PostureRecommandViewController(recommandViewModel)

    lazy var chestUseCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
    lazy var chestViewModel = PostureChestViewModel(useCase: chestUseCase)
    lazy var chestViewController = PostureChestViewController(chestViewModel)

    lazy var backUseCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
    lazy var backViewModel = PostureBackViewModel(useCase: backUseCase)
    lazy var backViewController = PostureBackViewController(backViewModel)

    private lazy var viewControllers: [UIViewController] = [
        recommandViewController,
        chestViewController,
        backViewController,
        backViewController,
        backViewController,
        backViewController,
        backViewController,
     ]

    private lazy var containerView: UIView = {
         let view = UIView()
         return view
     }()

    private var currentVC: UIViewController?

    public override func viewDidLoad() {
        super.viewDidLoad()

        bindEvents()
        pagingTabBar.selectedIndex.onNext(0)
    }

    public override func attribute() {
        view.backgroundColor = .white
    }

    public override func layout() {
        view.addSubviews([titleText,
                          pagingTabBar,
                          containerView])

        titleText.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(48.0)
        }

        pagingTabBar.snp.makeConstraints {
           $0.top.equalTo(titleText.snp.bottom).offset(12.0)
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



