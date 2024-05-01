import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGLogger

import PostureFeatureInterface

public class PostureSearchViewController: BaseViewController<PostureSearchViewModel>, Stepper {

    private var searchModel = PostureSearchModel(searchResultData: [])

    private var containerView = BaseView()

    private var beforeButton = BaseButton()

    private var searchBarView = MGSearchView()

    private var postureSearchTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PostureSearchTableViewCell.self, forCellReuseIdentifier: PostureSearchTableViewCell.identifier)
    }

    public override func attribute() {
        super.attribute()

        beforeButton.setImage(image: DSKitAsset.Assets.leftOpenArrow.image)
        postureSearchTableView.dataSource = self
        postureSearchTableView.delegate = self
    }

    override public func layout() {
        super.layout()

        view.addSubviews([containerView, postureSearchTableView])
        containerView.addSubviews([beforeButton, searchBarView])

        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.0)
        }

        beforeButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.height.equalTo(24.0)
        }

        searchBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.0)
            $0.leading.equalTo(beforeButton.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(40.0)
        }

        postureSearchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()

//        let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
//        viewModel = PostureSearchViewModel(useCase: useCase)

        let input = PostureSearchViewModel.Input(
            getSearchData: Observable.just(()).asDriver(onErrorDriveWith: .never())
        )
        
        beforeButton.rx.tap.subscribe(onNext: {
            PostureStepper.shared.steps.accept(MGStep.postureBack)
        }).disposed(by: disposeBag)

        _ = viewModel.transform(input, action: { optput in
            optput.searchData
                .subscribe(onNext: { searchData in
                    MGLogger.debug("searchData: \(searchData)")
                    self.searchModel = searchData
                }).disposed(by: disposeBag)
            }
        )
    }
}

extension PostureSearchViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 96
    }
}

extension PostureSearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchModel.searchResultData.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostureSearchTableViewCell.identifier, for: indexPath) as? PostureSearchTableViewCell
        let model = searchModel.searchResultData[indexPath.row]
        cell?.setup(with: model)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}
