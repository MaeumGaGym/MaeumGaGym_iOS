import UIKit

import SnapKit
import Then

import Core
import DSKit

public class SelfCareMyRoutineDetailViewController: BaseViewController<SelfCareMyRoutineDetailViewModel> {
    
    private var myRoutineDetailModel = SelfCareMyRoutineDetailModel.detailData
    
    private var containerView = UIView()
    private var headerView = UIView()
    
    private let myRoutineTitleLabel = UILabel().then {
        $0.text = "주말 루틴"
        $0.textColor = .black
        $0.contentMode = .left
        $0.font = UIFont.Pretendard.titleLarge
    }
    
    private var routineStateLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.text = "사용중 • 공유됨"
        $0.textColor = DSKitAsset.Colors.blue500.color
    }
    
    private var sharedView = MGShareStateView()
    
    private var myRoutineDetailTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(MyRoutineDetailTableViewCell.self,
                    forCellReuseIdentifier: MyRoutineDetailTableViewCell.identifier)
    }
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        sharedView.changeView(backColor: DSKitAsset.Colors.gray50.color)
    }
    
    public override func attribute() {
        super.attribute()
        
        myRoutineDetailTableView.delegate = self
        myRoutineDetailTableView.dataSource = self
    }
    
    public override func layout() {
        super.layout()
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 136.0))
        view.addSubviews([headerView, myRoutineDetailTableView])
        
        headerView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(32.0)
        }
        
        containerView.addSubviews([myRoutineTitleLabel, routineStateLabel, sharedView])
        
        myRoutineTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        routineStateLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        sharedView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.width.equalTo(98.0)
            $0.height.equalTo(36.0)
        }
        
        myRoutineDetailTableView.tableHeaderView = headerView
        myRoutineDetailTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
extension SelfCareMyRoutineDetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == myRoutineDetailModel.data.count + 1 {
            return 100
        } else {
            return 94
        }
    }
}
extension SelfCareMyRoutineDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRoutineDetailModel.data.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == myRoutineDetailModel.data.count {
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MyRoutineDetailTableViewCell.identifier,
                for: indexPath) as? MyRoutineDetailTableViewCell
            let detailData = myRoutineDetailModel.data[indexPath.row]
            cell?.setup(image: detailData.image, name: detailData.name, routine: detailData.routine)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}

