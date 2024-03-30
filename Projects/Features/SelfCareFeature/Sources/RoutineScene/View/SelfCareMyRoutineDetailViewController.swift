import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import Data
import DSKit

import Domain
import MGLogger
import MGNetworks

import SelfCareFeatureInterface

public class SelfCareMyRoutineDetailViewController: BaseViewController<SelfCareMyRoutineDetailViewModel> {

    private var myRoutineDetailModel: SelfCareMyRoutineDetailModel = SelfCareMyRoutineDetailModel(
        routineTitleData: SelfCareRoutineModel(routineNameText: "",
                                               usingState: false,
                                               sharingState: false),
        routinesData: [])

    private var headerView = UIView()

    private var titleView = MyRoutineDetailTitleView()

    private var myRoutineDetailTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(MyRoutineDetailTableViewCell.self,
                    forCellReuseIdentifier: MyRoutineDetailTableViewCell.identifier)
    }

    private var bottomLine = MGLine(lineHeight: 1)
    private var bottomContainerView = UIView()
    private var buttonBackView = UIView()

    private var deleteRoutineButton = SelfCareButton(type: .deleteRotine)
    private var editRoutineButton = SelfCareButton(type: .editRoutine)
    private var dotsButton = MGImageButton(image: DSKitAsset.Assets.dotsActIcon.image)

    public override func attribute() {
        super.attribute()

        view.backgroundColor = .white

        myRoutineDetailTableView.delegate = self
        myRoutineDetailTableView.dataSource = self
    }

    public override func layout() {
        super.layout()

        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 136.0))
        view.addSubviews([headerView, myRoutineDetailTableView, bottomContainerView])

        headerView.addSubview(titleView)

        titleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(32.0)
        }

        myRoutineDetailTableView.tableHeaderView = headerView
        myRoutineDetailTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomContainerView.snp.top)
        }

        bottomContainerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(98.0)
        }

        bottomContainerView.addSubviews([bottomLine, buttonBackView, dotsButton])
        buttonBackView.addSubviews([deleteRoutineButton, editRoutineButton])

        bottomLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        dotsButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(33.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.width.height.equalTo(32.0)
        }

        buttonBackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalTo(dotsButton.snp.leading).offset(-20.0)
        }

        deleteRoutineButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(buttonBackView.snp.centerX).inset(4.0)
        }

        editRoutineButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(buttonBackView.snp.centerX).offset(4.0)
        }
    }

    public override func bindViewModel() {
        let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: SelfCareService()))
        viewModel = SelfCareMyRoutineDetailViewModel(useCase: useCase)

        let input = SelfCareMyRoutineDetailViewModel.Input(
            getMyRoutineDetailData: Observable.just(()).asDriver(onErrorDriveWith: .never()))

        let output = viewModel.transform(input, action: { output in
            output.myRoutineDetailData
                .subscribe(onNext: { myRoutineDetailData in
                    MGLogger.debug("myRoutineDetailData: \(myRoutineDetailData)")
                    self.myRoutineDetailModel = myRoutineDetailData
                    self.titleView.setup(with: myRoutineDetailData.routineTitleData)
                }).disposed(by: disposeBag)
        })
    }
}

extension SelfCareMyRoutineDetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == myRoutineDetailModel.routinesData.count + 1 {
            return 100
        } else {
            return 94
        }
    }
}

extension SelfCareMyRoutineDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRoutineDetailModel.routinesData.count + 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == myRoutineDetailModel.routinesData.count {
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MyRoutineDetailTableViewCell.identifier,
                for: indexPath) as? MyRoutineDetailTableViewCell
            let detailData = myRoutineDetailModel.routinesData[indexPath.row]
            cell?.setup(with: detailData)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}
