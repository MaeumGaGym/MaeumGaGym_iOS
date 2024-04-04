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

public class SelfCareMyRoutineEditViewController: BaseViewController<SelfCareMyRoutineEditViewModel>, Stepper, UIGestureRecognizerDelegate {

    private var myRoutineEditData: SelfCareMyRoutineEditModel =
    SelfCareMyRoutineEditModel(
        textFieldData:
            MyRoutineEditTextFieldModel(
            textFieldTitle: "",
            textFieldText: "", 
            textFieldPlaceholder: ""
            ), date: [],
        exerciseData: []
    )

    public var steps = PublishRelay<Step>()

    private var naviBar = RoutineNavigationBarBar()

    private var headerView = UIView()

    private var titleTextView = MGTitleTextFieldView(titleText: "제목", textLimit: 3, placeholder: "제목을 입력해주세요")
    
    private var textFieldData: MyRoutineEditTextFieldModel = MyRoutineEditTextFieldModel(
        textFieldTitle: "",
        textFieldText: "",
        textFieldPlaceholder: ""
    )
    private var myRoutineDetailTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(MyRoutineEditTableViewCell.self,
                    forCellReuseIdentifier: MyRoutineEditTableViewCell.identifier)
        $0.register(MyRoutineDateTableViewCell.self, forCellReuseIdentifier: MyRoutineDateTableViewCell.identifier)
    }

    private let underLine = MGLine(lineHeight: 1.0)
    private let underBackView = UIView()
    private let buttonSpaceView = UIView()

    private var plusPostureButton = SelfCareButton(type: .posturePlus)
    private var editButton = SelfCareButton(type: .edit)

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }

    public override func attribute() {
        super.attribute()

        naviBar.setLeftText(text: "주말 루틴 수정")

        myRoutineDetailTableView.delegate = self
        myRoutineDetailTableView.dataSource = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public override func layout() {
        super.layout()

        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 132.0))
        view.addSubviews([naviBar, myRoutineDetailTableView, underBackView])

        headerView.addSubview(titleTextView)

        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        titleTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(32.0)
        }

        myRoutineDetailTableView.tableHeaderView = headerView
        myRoutineDetailTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(105.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(695.0)
        }

        underBackView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(myRoutineDetailTableView.snp.bottom)
        }

        underBackView.addSubviews([underLine, buttonSpaceView, plusPostureButton, editButton])

        underLine.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }

        buttonSpaceView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(8.0)
            $0.centerX.equalToSuperview()
        }

        plusPostureButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalTo(buttonSpaceView.snp.leading)
        }

        editButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.leading.equalTo(buttonSpaceView.snp.trailing)
        }
    }

    public override func bindViewModel() {
        let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: SelfCareService()))

        viewModel = SelfCareMyRoutineEditViewModel(useCase: useCase)

        let input = SelfCareMyRoutineEditViewModel.Input(
            getMyRoutineEditData: Observable.just(()).asDriver(onErrorDriveWith: .never()))

        let output = viewModel.transform(input, action: { output in
            output.myRoutineEditData
                .subscribe(onNext: { myRoutineEditData in
                    MGLogger.debug("myRoutineEditData: \(myRoutineEditData)")
                    self.myRoutineEditData = myRoutineEditData
                    self.textFieldData = myRoutineEditData.textFieldData
                }).disposed(by: disposeBag)
        })
    }
}

extension SelfCareMyRoutineEditViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 104
        default:
            return 216
        }
    }
}

extension SelfCareMyRoutineEditViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myRoutineEditData.exerciseData.count + 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: MyRoutineDateTableViewCell.identifier, for: indexPath) as? MyRoutineDateTableViewCell
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MyRoutineEditTableViewCell.identifier,
                for: indexPath) as? MyRoutineEditTableViewCell
            let editData = myRoutineEditData.exerciseData[indexPath.row - 1]
            cell?.setup(with: editData)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
}
