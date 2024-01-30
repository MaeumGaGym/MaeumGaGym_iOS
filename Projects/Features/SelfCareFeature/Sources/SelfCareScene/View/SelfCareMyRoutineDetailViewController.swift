import UIKit

import SnapKit
import Then

import Core
import DSKit

public class SelfCareMyRoutineDetailViewController: BaseViewController<SelfCareMyRoutineDetailViewModel> {
    
    private var myRoutineDetailModel = SelfCareMyRoutineDetailModel.data
    
    private var containerView = UIView()
    private var headerView = UIView()
    
    private let myRoutineTitleLabel = UILabel().then {
        $0.text = "주말 루틴"
        $0.textColor = .black
        $0.contentMode = .left
        $0.font = UIFont.Pretendard.titleLarge
    }
    
    private let myRoutineSubTitleLabel = UILabel().then {
        $0.text = "나만의 루틴을 구성하여\n규칙적인 운동을 해보세요."
        $0.numberOfLines = 2
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.font = UIFont.Pretendard.bodyMedium
    }
    
    private var myRoutineTableView = UITableView().then {
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
    }
    
    public override func attribute() {
        
        myRoutineTableView.delegate = self
        myRoutineTableView.dataSource = self
    }
    
    public override func layout() {
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 144.0))
        view.addSubview(headerView)
        
        headerView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(20.0)
        }
        
        containerView.addSubview(myRoutineTitleLabel)
        containerView.addSubview(myRoutineSubTitleLabel)
        
        myRoutineTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        myRoutineSubTitleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(40.0)
        }
        
        view.addSubview(myRoutineTableView)
        myRoutineTableView.tableHeaderView = headerView
        myRoutineTableView.snp.makeConstraints {
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
            let data = myRoutineDetailModel.data[indexPath.row]
            cell?.setup(image: data.image, name: data.name, routine: data.routine)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}

