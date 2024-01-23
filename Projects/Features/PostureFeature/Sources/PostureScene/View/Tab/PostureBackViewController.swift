import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then


import Core
import DSKit
import MGLogger
import PostureFeatureInterface

public class PostureBackViewController: BaseViewController<PostureChestViewModel> {

    private var chestModel = PostureChestModel.first

    private var postureChestTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PostureChestToggleTableViewCell.self,
                    forCellReuseIdentifier: PostureChestToggleTableViewCell.identifier)
        $0.register(PostureChestTableViewCell.self,
                    forCellReuseIdentifier: PostureChestTableViewCell.identifier)
    }

    public override func attribute() {
        super.attribute()

        postureChestTableView.dataSource = self
        postureChestTableView.delegate = self
    }

    public override func layout() {
        super.layout()
        view.addSubview(postureChestTableView)

        postureChestTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.width.equalToSuperview().inset(8.0)
            $0.height.equalTo(613.0)
            $0.top.equalToSuperview().offset(12.0)
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()
        chestModel = PostureChestModel.first
    }
}

extension PostureBodyViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else {
            return 88
        }
    }
}

extension PostureBodyViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 8
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PostureChestToggleTableViewCell.identifier,
                for: indexPath
            ) as? PostureChestToggleTableViewCell
            cell?.setup(firstType: .bareBody, secondType: .marchine)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PostureChestTableViewCell.identifier,
                for: indexPath) as? PostureChestTableViewCell
            let exercise = chestModel.data[indexPath.row - 1]
            cell?.setup(exerciseImage: exercise.image, exerciseNameText: exercise.name)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}
