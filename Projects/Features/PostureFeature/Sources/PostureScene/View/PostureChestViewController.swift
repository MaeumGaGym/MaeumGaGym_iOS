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

public class PostureChestViewController: BaseViewController<PostureChestViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var chestModel: PostureChestModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        chestModel = PostureChestModel.first
        
        tableView = UITableView().then {
            $0.dataSource = self
            $0.delegate = self
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.separatorStyle = .none
            $0.register(PostureChestToggleTableViewCell.self, forCellReuseIdentifier: PostureChestToggleTableViewCell.identifier)
                   $0.register(PostureChestTableViewCell.self, forCellReuseIdentifier: PostureChestTableViewCell.identifier)
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(613.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstCell = tableView.dequeueReusableCell(withIdentifier: PostureChestToggleTableViewCell.identifier, for: indexPath) as! PostureChestToggleTableViewCell
        let secondCell = tableView.dequeueReusableCell(withIdentifier: PostureChestTableViewCell.identifier, for: indexPath) as! PostureChestTableViewCell
        if indexPath.row == 0 {
            firstCell.setup(firstType: .bareBody, secondType: .marchine)
            firstCell.selectionStyle = .none
            return firstCell
        } else {
            let exercise = chestModel.data[indexPath.row - 1] // 첫 번째 행을 제외한 나머지 행에서 사용될 데이터를 가져옵니다.
            secondCell.setup(exerciseImage: exercise.image, exerciseNameText: exercise.name)
            secondCell.selectionStyle = .none
            return secondCell
        }
    }
}
