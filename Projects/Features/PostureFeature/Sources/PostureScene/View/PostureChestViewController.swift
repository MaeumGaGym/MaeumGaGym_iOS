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

public class PostureChestViewController: BaseViewController<PostureChestViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    private var postureChestTableView: UITableView!
    private var chestModel: PostureChestModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        chestModel = PostureChestModel.first
        
        postureChestTableView = UITableView().then {
            $0.dataSource = self
            $0.delegate = self
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.separatorStyle = .none
            $0.register(PostureChestToggleTableViewCell.self, forCellReuseIdentifier: PostureChestToggleTableViewCell.identifier)
            $0.register(PostureChestTableViewCell.self, forCellReuseIdentifier: PostureChestTableViewCell.identifier)
        }
        
        view.addSubview(postureChestTableView)
        
        postureChestTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8) // 좌우 간격 설정
            $0.width.equalToSuperview()
            $0.height.equalTo(613.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // 셀 높이 설정
        if indexPath.row == 0 {
            return 60
        } else {
            return 88
        }
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostureChestToggleTableViewCell.identifier, for: indexPath) as! PostureChestToggleTableViewCell
            cell.setup(firstType: .bareBody, secondType: .marchine)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostureChestTableViewCell.identifier, for: indexPath) as! PostureChestTableViewCell
            let exercise = chestModel.data[indexPath.row - 1] // 첫 번째 행을 제외한 나머지 행에서 사용될 데이터를 가져옵니다.
            cell.setup(exerciseImage: exercise.image, exerciseNameText: exercise.name)
            cell.selectionStyle = .none
            return cell
        }
        
        
    }

}

