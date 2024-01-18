import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import MGLogger
import PostureFeatureInterface

public class PostureChestViewController: BaseViewController<PostureChestViewModel> {

    private var chestModel: PostureChestModel!

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
            $0.width.equalToSuperview()
            $0.height.equalTo(613.0)
            $0.bottom.equalToSuperview()
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()
        chestModel = PostureChestModel.first
    }
}

extension PostureChestViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else {
            return 88
        }
    }
}

extension PostureChestViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
