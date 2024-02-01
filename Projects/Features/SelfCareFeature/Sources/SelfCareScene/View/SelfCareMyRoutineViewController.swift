import UIKit

import SnapKit
import Then

import Core
import DSKit
import SelfCareFeatureInterface

public class SelfCareMyRoutineViewController: BaseViewController<SelfCareMyRoutineViewModel> {
    private var myRoutineModel = SelfCareMyRoutineModel.myRoutine
    
    private var containerView = UIView()
    private var headerView = UIView()
    
    private let myRoutineTitleLabel = UILabel().then {
        $0.text = "내 루틴"
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
        $0.register(MyRoutineTableViewCell.self,
                    forCellReuseIdentifier: MyRoutineTableViewCell.identifier)
    }
    
    private var plusRoutineButton = SelfCareButton(type: .plusRoutine)
    
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
        
        view.addSubview(plusRoutineButton)
        plusRoutineButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-54.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(58.0)
        }
        
    }
}
extension SelfCareMyRoutineViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == myRoutineModel.data.count + 1 {
            return 100
        } else {
            return 94
        }
    }
}
extension SelfCareMyRoutineViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRoutineModel.data.count + 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == myRoutineModel.data.count {
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MyRoutineTableViewCell.identifier,
                for: indexPath) as? MyRoutineTableViewCell
            let routine = myRoutineModel.data[indexPath.row]
            cell?.setup(name: routine.name, state: routine.routineState, shared: routine.sharedState)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}
