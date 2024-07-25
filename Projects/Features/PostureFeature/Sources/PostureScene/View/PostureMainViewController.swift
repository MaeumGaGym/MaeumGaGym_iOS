import UIKit
import Data

import RxCocoa
import RxSwift
import RxFlow

import SnapKit
import Then

import DSKit
import Core
import Domain

import MGNetworks
import MGLogger

import PostureFeatureInterface

public class PostureMainViewController: BaseViewController<PostureMainViewModel>, Stepper {
    
    private lazy var naviBar = PostureMainNavigationBar()
    
    let rootViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    
    private let categoryTitleList = [
        "추천",
        "가슴",
        "등",
        "어깨",
        "팔",
        "하체",
        "복근"
    ]
    
    private let titleText = MGLabel(text: "자세",
                                    font: UIFont.Pretendard.titleLarge,
                                    textColor: .black,
                                    isCenter: false
    )
    
    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }
    
    private lazy var pagingTabBar = MGPagingTabBar(categoryTitleList: categoryTitleList)
    
    lazy var postureUseCase = DefaultPostureUseCase(repository: PostureRepository(networkService: DefaultPostureService()))
    
    lazy var recommandViewController = PostureRecommandViewController(PostureRecommandViewModel(useCase: postureUseCase))
    lazy var chestViewController = PostureChestViewController(PostureChestViewModel(useCase: postureUseCase))
    lazy var backViewController = PostureBackViewController(PostureBackViewModel(useCase: postureUseCase))
    lazy var shoulderViewController = PostureShoulderViewController(PostureShoulderViewModel(useCase: postureUseCase))
    lazy var armViewController = PostureArmViewController(PostureArmViewModel(useCase: postureUseCase))
    lazy var legViewController = PostureLegViewController(PostureLegViewModel(useCase: postureUseCase))
    
    private lazy var viewControllers: [UIViewController] = [
        recommandViewController,
        chestViewController,
        backViewController,
        shoulderViewController,
        armViewController,
        legViewController,
        chestViewController,
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
        view.addSubviews([naviBar,
                          titleText,
                          pagingTabBar,
                          containerView])
        
        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleText.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(48.0)
        }
        
        pagingTabBar.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56.0)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(pagingTabBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func bindEvents() {
        pagingTabBar.selectedIndex
            .withUnretained(self)
            .subscribe(onNext: { owner, index in
                if let currentVC = owner.currentVC {
                    currentVC.willMove(toParent: nil)
                    currentVC.view.removeFromSuperview()
                    currentVC.removeFromParent()
                }
                
                let vcToAdd = owner.viewControllers[index]
                
                owner.addChild(vcToAdd)
                
                vcToAdd.view.frame = owner.containerView.bounds
                
                owner.containerView.addSubview(vcToAdd.view)
                
                vcToAdd.didMove(toParent: owner)
                
            }).disposed(by: disposeBag)
        
        recommandViewController.categoryClicked = { [weak self] index in
            MGLogger.debug(index)
            self?.pagingTabBar.selectItem(at: index + 1)
        }
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        let searchButtonTapped = naviBar.rightButtonTap.asDriver(onErrorDriveWith: .never())
        
        let input = PostureMainViewModel.Input(
            searchButtonTapped: searchButtonTapped
        )
        
        _ = viewModel.transform(input, action: { output in
            
        })
    }
}
