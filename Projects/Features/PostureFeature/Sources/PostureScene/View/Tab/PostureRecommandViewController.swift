import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import DSKit
import MGLogger

import Domain

import PostureFeatureInterface

public class PostureRecommandViewController: BaseViewController<PostureRecommandViewModel>, UITableViewDelegate {
    
    private var poseIsClicked: ((Int) -> Void)?
    public var categoryClicked: ((Int) -> Void)?
    
    private var recommandData: PoseRecommandModel = PoseRecommandModel(responses: [])

    private var recommandTableView: UITableView = UITableView().then {
        $0.register(PostureRecommandTableViewCell.self,
                    forCellReuseIdentifier: PostureRecommandTableViewCell.identifier)
        $0.rowHeight = 312
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    public override func attribute() {
        self.tabBarController?.tabBar.backgroundColor = .white
        recommandTableView.dataSource = self
        recommandTableView.delegate = self
    }
    
    public override func configureNavigationBar() {
        recommandTableView.frame = recommandTableView.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }
    
    public override func layout() {
        super.layout()
        view.addSubviews([recommandTableView])
        
        recommandTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        let poseClickSubject = PublishSubject<Int>()
        
        let input = PostureRecommandViewModel.Input(
            poseIsClicked: poseClickSubject.asDriver(onErrorDriveWith: .empty()),
            getRecommandData: Observable.just(()).asDriver(onErrorDriveWith: .empty())
        )
        
        _ = viewModel.transform(input, action: { output in
            output.recommandData
                .subscribe(onNext: { recommandData in
                    MGLogger.debug("Recommand Data: \(recommandData)")
                    self.recommandData = recommandData
                    self.recommandTableView.reloadData()
                }).disposed(by: disposeBag)
        })
        
        poseIsClicked = { [weak poseClickSubject] poseId in
            poseClickSubject?.onNext(poseId)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let tabBar = self.tabBarController?.tabBar else { return }
            tabBar.backgroundColor = .white
        }
}


extension PostureRecommandViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return recommandData.responses.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostureRecommandTableViewCell.identifier, for: indexPath) as? PostureRecommandTableViewCell else {
            return UITableViewCell()
        }
        let model = recommandData.responses[indexPath.row]
        cell.setup(with: model, titleText: model.category)
        cell.selectionStyle = .none
        
        cell.poseIsClicked = { [weak self] poseId in
            self?.poseIsClicked?(poseId)
        }
        
        cell.seemoreButtonIsTap = { [weak self] category in
            switch category {
            case "가슴":
                self?.categoryClicked?(0)
            case "등":
                self?.categoryClicked?(1)
            case "어깨":
                self?.categoryClicked?(2)
            case "팔":
                self?.categoryClicked?(3)
            case "하체":
                self?.categoryClicked?(4)
            default:
                MGLogger.debug("더보기 버튼 에러 : \(category)")
            }
        }

        return cell
    }
}

