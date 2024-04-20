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
import MGNetworks
import Data

import PostureFeatureInterface

public class PostureDetailViewController: BaseViewController<PostureDetailViewModel> {

    private var postureDetailTableView = UITableView().then {
        $0.register(PostureDetailImageTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailImageTableViewCell.identifier)
        $0.register(PostureDetailTitleTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTitleTableViewCell.identifier)
        $0.register(PostureDetailTagTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTagTableViewCell.identifier)
        $0.register(PostureDetailInfoTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailInfoTableViewCell.identifier)
        $0.register(PostureDetailInfoTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailInfoTableViewCell.identifier)
        $0.register(PostureDetailPickeTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailPickeTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    private var postureDetailModel: PostureDetailModel = PostureDetailModel(
        detailImage: UIImage(),
        titleTextData: PostureDetailTitleTextModel(englishName: "", koreanName: ""),
        exerciseKindData: [PostureDetailExerciseKindModel](),
        exerciseWayData: PostureDetailInfoModel(titleText: "", infoText: []),
        exerciseCautionData: PostureDetailInfoModel(titleText: "", infoText: []),
        relatedPickleData: PostureDetailPickleModel(titleText: "", pickleImage: [])
    )

    public override func attribute() {
        super.attribute()

        postureDetailTableView.dataSource = self
        postureDetailTableView.delegate = self
    }

    public override func layout() {
        super.layout()

        view.addSubview(postureDetailTableView)

        postureDetailTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(105.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()

        let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
        viewModel = PostureDetailViewModel(useCase: useCase)

        let input = PostureDetailViewModel.Input(
            getDetailData: Observable.just(()).asDriver(onErrorDriveWith: .never())
        )

        _ = viewModel.transform(input, action: { optput in
            optput.detailData
                .subscribe(onNext: { detailData in
                    MGLogger.debug("detailData: \(detailData)")
                    self.postureDetailModel = detailData
                }).disposed(by: disposeBag)
            }
        )
    }
}

extension PostureDetailViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 120
        case 2:
            return 60
        case 3:
            let model = postureDetailModel.exerciseWayData.infoText
            var lineCount = 0
            for data in model {
                lineCount += data.text.components(separatedBy: "\n").count - 1
            }
            print("\(lineCount)")
            print("\(model.count)")
            print(92 + (model.count * 48) + (lineCount * 20))
            return CGFloat(92 + (model.count * 48) + (lineCount * 20))
        case 4:
            let model = postureDetailModel.exerciseCautionData.infoText
            var lineCount = 0
            for data in model {
                lineCount += data.text.components(separatedBy: "\n").count - 1
            }
            return CGFloat(92 + (model.count * 48) + (lineCount * 20))
        case 5:
            return 360
        default:
            return UITableView.automaticDimension
        }
    }
}

extension PostureDetailViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 6
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailImageTableViewCell.identifier,
                for: indexPath) as? PostureDetailImageTableViewCell
            let model = postureDetailModel.detailImage
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 1:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTitleTableViewCell.identifier,
                for: indexPath) as? PostureDetailTitleTableViewCell
            let model = postureDetailModel.titleTextData
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 2:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTagTableViewCell.identifier,
                for: indexPath) as? PostureDetailTagTableViewCell
            let model = postureDetailModel.exerciseKindData
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 3:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailInfoTableViewCell.identifier,
                for: indexPath) as? PostureDetailInfoTableViewCell
            let model = postureDetailModel.exerciseWayData
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 4:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailInfoTableViewCell.identifier,
                for: indexPath) as? PostureDetailInfoTableViewCell
            let model = postureDetailModel.exerciseCautionData
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 5:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailPickeTableViewCell.identifier,
                for: indexPath) as? PostureDetailPickeTableViewCell
            let model = postureDetailModel.relatedPickleData
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
