import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import PostureFeatureInterface

public class PostureDetailViewController: BaseViewController<PostureDetailViewModel> {

    var postureDetailTableView = UITableView().then {
        $0.register(PostureDetailImageTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailImageTableViewCell.identifier)
        $0.register(PostureDetailTitleTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTitleTableViewCell.identifier)
        $0.register(PostureDetailTagTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTagTableViewCell.identifier)
        $0.register(PostureDetailExerciseInfoTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailExerciseInfoTableViewCell.identifier)
        $0.register(PostureDetailCautionTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailCautionTableViewCell.identifier)
        $0.register(PostureDetailPickeTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailPickeTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    var titleImageModel: PostureTitleImageModel!
    var titleLabelModel: PostureTitleLabelModel!
    var titleTagModel: PostureTagLabelModel!
    var exerciseWayModel: PostureExerciseWayModel!
    var exerciseCautionModel: PostureExerciseCautionModel!
    var relatedPickleModel: PostureRelatedPickleModel!

    public override func attribute() {
        super.attribute()

        postureDetailTableView.dataSource = self
        postureDetailTableView.delegate = self
    }

    public override func bindViewModel() {
        super.bindViewModel()
        titleImageModel = PostureTitleImageModel.pushUpModel
        titleLabelModel = PostureTitleLabelModel.pushUpModel
        titleTagModel = PostureTagLabelModel.pushUpModel
        exerciseWayModel = PostureExerciseWayModel.pushUpModel
        exerciseCautionModel = PostureExerciseCautionModel.pushUpModel
        relatedPickleModel = PostureRelatedPickleModel.pushUpModel
    }

    public override func layout() {
        super.layout()

        view.addSubview(postureDetailTableView)

        postureDetailTableView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(105.0)
        }
    }
}

extension PostureDetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 120
        case 2:
            return 60
        case 3:
            return 252
        case 4:
            return 204
        case 5:
            return 394
        default:
            return UITableView.automaticDimension
        }
    }
}

extension PostureDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailImageTableViewCell.identifier,
                for: indexPath) as? PostureDetailImageTableViewCell
            cell?.setup(image: titleImageModel.data)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 1:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTitleTableViewCell.identifier,
                for: indexPath) as? PostureDetailTitleTableViewCell
            cell?.setup(englishText: titleLabelModel.englishName, koreanText: titleLabelModel.koreanName)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 2:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTagTableViewCell.identifier,
                for: indexPath) as? PostureDetailTagTableViewCell
            cell?.setup(exerciseNameText: titleTagModel.exerciseType, exercisePartText: titleTagModel.exercisePart)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 3:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailExerciseInfoTableViewCell.identifier,
                for: indexPath) as? PostureDetailExerciseInfoTableViewCell
            cell?.setup(model: PostureExerciseWayModel.pushUpModel)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 4:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailCautionTableViewCell.identifier,
                for: indexPath) as? PostureDetailCautionTableViewCell
            cell?.setup(model: PostureExerciseCautionModel.pushUpModel)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 5:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailPickeTableViewCell.identifier,
                for: indexPath) as? PostureDetailPickeTableViewCell
            cell?.setupCell(model: PostureRelatedPickleModel.pushUpModel)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
