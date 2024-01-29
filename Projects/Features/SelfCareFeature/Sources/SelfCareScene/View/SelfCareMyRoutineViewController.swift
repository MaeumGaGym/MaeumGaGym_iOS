import UIKit

import SnapKit
import Then

import Core
import DSKit

public class SelfCareMyRoutineViewController: BaseViewController<SelfCareMyRoutineViewModel> {
    
    private var myRoutineModel = SelfCareMyRoutineModel.myRoutine
    
    private var headerView = UIView()
    
    private let myRoutineTitleLabel = UILabel().then {
        $0.text = "내 루틴"
        $0.textColor = .black
        $0.contentMode = .left
    }
    
    private let myRoutineSubTitleLabel = UILabel().then {
        $0.text = "나만의 루틴을 구성하여\n규칙적인 운동을 해보세요."
        $0.numberOfLines = 2
        $0.textColor = DSKitAsset.Colors.gray600.color
    }
    
    private var myRoutineTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        
        $0.register(MyRoutineTableViewCell.self,
                    forCellReuseIdentifier: MyRoutineTableViewCell.identifier)
    }
    
    private var plusRoutineButton = MyRoutinePlusButton(text: "루틴 추가하기")
    
    public override func layout() {
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100.0))
        
        headerView.addSubview(myRoutineTitleLabel)
        headerView.addSubview(myRoutineSubTitleLabel)
        
        myRoutineTableView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        myRoutineSubTitleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(40.0)
        }
        
        myRoutineTableView.tableHeaderView = headerView
        view.addSubview(myRoutineTableView)
        
        myRoutineTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
    }
}

extension SelfCareMyRoutineViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}

extension SelfCareMyRoutineViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MyRoutineTableViewCell.identifier,
            for: indexPath) as? MyRoutineTableViewCell
        let routine = SelfCareMyRoutineViewModel.data[indexPath.row]
        cell?.setup(name: routine.name, state: routine.routineState, shared: routine.sharedState)
        return cell ?? UITableViewCell()
    }
}
