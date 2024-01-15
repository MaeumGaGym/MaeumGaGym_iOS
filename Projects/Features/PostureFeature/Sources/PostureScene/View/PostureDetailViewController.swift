import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import CSLogger
import PostureFeatureInterface

public class PostureDetailViewController: BaseViewController<PostureDetailViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    var postureDetailTableView: UITableView!
    
    var titleImageModel: postureTitleImageModel!
    var titleLabelModel: postureTitleLabelModel!
    var titleTagModel: postureTagLabelModel!
    var exerciseWayModel: postureExerciseWayModel!
    var exerciseCautionModel: postureExerciseCautionModel!
    var relatedPickleModel: postureRelatedPickleModel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        titleImageModel = postureTitleImageModel.pushUpModel
        titleLabelModel = postureTitleLabelModel.pushUpModel
        titleTagModel = postureTagLabelModel.pushUpModel
        exerciseWayModel = postureExerciseWayModel.pushUpModel
        exerciseCautionModel = postureExerciseCautionModel.pushUpModel
        relatedPickleModel = postureRelatedPickleModel.pushUpModel
        
        postureDetailTableView = UITableView().then {
            $0.dataSource = self
            $0.delegate = self
            $0.register(PostureDetailImageTableViewCell.self, forCellReuseIdentifier: PostureDetailImageTableViewCell.identifier)
            $0.register(PostureDetailTitleTableViewCell.self, forCellReuseIdentifier: PostureDetailTitleTableViewCell.identifier)
            $0.register(PostureDetailTagTableViewCell.self, forCellReuseIdentifier: PostureDetailTagTableViewCell.identifier)
            $0.register(PostureDetailExerciseInfoTableViewCell.self, forCellReuseIdentifier: PostureDetailExerciseInfoTableViewCell.identifier)
            $0.register(PostureDetailCautionTableViewCell.self, forCellReuseIdentifier: PostureDetailCautionTableViewCell.identifier)
            $0.register(PostureDetailPickeTableViewCell.self, forCellReuseIdentifier: PostureDetailPickeTableViewCell.identifier)
            
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.separatorStyle = .none

        }
        
        view.addSubview(postureDetailTableView)
        
        postureDetailTableView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(105.0)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = postureDetailTableView.dequeueReusableCell(withIdentifier: PostureDetailImageTableViewCell.identifier, for: indexPath) as! PostureDetailImageTableViewCell
            
            cell.setup(image: titleImageModel.data)
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = postureDetailTableView.dequeueReusableCell(withIdentifier: PostureDetailTitleTableViewCell.identifier, for: indexPath) as! PostureDetailTitleTableViewCell
            
            cell.setup(englishText: titleLabelModel.englishName, koreanText: titleLabelModel.koreanName)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = postureDetailTableView.dequeueReusableCell(withIdentifier: PostureDetailTagTableViewCell.identifier, for: indexPath) as! PostureDetailTagTableViewCell
            
            cell.setup(exerciseNameText: titleTagModel.exerciseType, exercisePartText: titleTagModel.exercisePart)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = postureDetailTableView.dequeueReusableCell(withIdentifier: PostureDetailExerciseInfoTableViewCell.identifier, for: indexPath) as! PostureDetailExerciseInfoTableViewCell
            
            cell.setup(model: postureExerciseWayModel.pushUpModel)
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = postureDetailTableView.dequeueReusableCell(withIdentifier: PostureDetailCautionTableViewCell.identifier, for: indexPath) as! PostureDetailCautionTableViewCell
            
            cell.setup(model: postureExerciseCautionModel.pushUpModel)
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = postureDetailTableView.dequeueReusableCell(withIdentifier: PostureDetailPickeTableViewCell.identifier, for: indexPath) as! PostureDetailPickeTableViewCell
            
            cell.setupCell(model: postureRelatedPickleModel.pushUpModel)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
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
