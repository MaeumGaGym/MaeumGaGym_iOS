import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import DSKit
import MGLogger

import Domain
import Data
import MGNetworks

import SelfCareFeatureInterface

public class SelfCareMyRoutineViewController: BaseViewController<SelfCareMyRoutineViewModel> {

    private var myRoutineModel: SelfCareMyRoutineModel = SelfCareMyRoutineModel(
        titleTextData:
            SelfCareMyRoutineTextModel(
                titleText: "",
                infoText: ""),
        myRoutineData: []
    )

    private var containerView = UIView()
    private var headerView = UIView()

    private let myRoutineTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.contentMode = .left
        $0.font = UIFont.Pretendard.titleLarge
    }

    private let myRoutineSubTitleLabel = UILabel().then {
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

    public override func attribute() {
        super.attribute()

        view.backgroundColor = .white

        myRoutineTitleLabel.text = myRoutineModel.titleTextData.titleText
        myRoutineSubTitleLabel.text = myRoutineModel.titleTextData.infoText

        myRoutineTableView.delegate = self
        myRoutineTableView.dataSource = self
    }

    public override func layout() {
        super.layout()

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

    public override func bindViewModel() {
        let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: SelfCareService()))

        viewModel = SelfCareMyRoutineViewModel(useCase: useCase)

        let input = SelfCareMyRoutineViewModel.Input(
            getMyRoutineData: Observable.just(()).asDriver(onErrorDriveWith: .never()))

        let output = viewModel.transform(input, action: { output in
            output.myRoutineData
                .subscribe(onNext: { myRoutineData in
                    MGLogger.debug("myRoutineData: \(myRoutineData)")
                    self.myRoutineModel = myRoutineData
                }).disposed(by: disposeBag)
        })
    }
}

extension SelfCareMyRoutineViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == myRoutineModel.myRoutineData.count + 1 {
            return 100
        } else {
            return 94
        }
    }
}
extension SelfCareMyRoutineViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRoutineModel.myRoutineData.count + 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == myRoutineModel.myRoutineData.count {
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MyRoutineTableViewCell.identifier,
                for: indexPath) as? MyRoutineTableViewCell
            let routine = myRoutineModel.myRoutineData[indexPath.row]
            cell?.setup(with: routine)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}
