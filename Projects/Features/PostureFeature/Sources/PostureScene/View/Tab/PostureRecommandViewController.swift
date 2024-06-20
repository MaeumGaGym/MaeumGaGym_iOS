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

public class PostureRecommandViewController: BaseViewController<PostureRecommandViewModel> {

    private var recommandData: PoseRecommandModel = PoseRecommandModel(
        poses: PoseRecommandPartModel(
            어깨: PoseRecommandPartResponseModel(responses: []),
            복근:  PoseRecommandPartResponseModel(responses: []),
            등:  PoseRecommandPartResponseModel(responses: []),
            가슴:  PoseRecommandPartResponseModel(responses: []),
            팔:  PoseRecommandPartResponseModel(responses: [])
        )
    )

    private var recommandTableView: UITableView = UITableView().then {
        $0.register(PostureRecommandTableViewCell.self,
                    forCellReuseIdentifier: PostureRecommandTableViewCell.identifier)
        $0.rowHeight = 292
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    public override func attribute() {
        recommandTableView.dataSource = self
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

        let input = PostureRecommandViewModel.Input(
            getRecommandData:
                Observable.just(())
                .asDriver(onErrorDriveWith: .never())
        )

        _ = viewModel.transform(input, action: { output in
            output.recommandData
                .subscribe(onNext: { recommandData in
                    MGLogger.debug("Recommand Data: \(recommandData)")
                    self.recommandData = recommandData
                }).disposed(by: disposeBag)
        })
    }
}

extension PostureRecommandViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 5
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostureRecommandTableViewCell.identifier,
            for: indexPath
        ) as? PostureRecommandTableViewCell
        let model = recommandData.poses
        switch indexPath.row {
        case 0:
            cell?.setup(with: model.가슴.responses, titleText: "가슴")
        case 1:
            cell?.setup(with: model.등.responses, titleText: "등")
        case 2:
            cell?.setup(with: model.복근.responses, titleText: "복근")
        case 3:
            cell?.setup(with: model.어깨.responses, titleText: "어깨")
        case 4:
            cell?.setup(with: model.팔.responses, titleText: "팔")
        default:
            cell?.setup(with: model.가슴.responses, titleText: "가슴")
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}
