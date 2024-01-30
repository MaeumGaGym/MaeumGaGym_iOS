import UIKit

import RxSwift
import RxCocoa
import RxFlow

import Then
import SnapKit

import Core
import DSKit

import HomeFeatureInterface

enum HomeCell {
    case motivationMessage
    case stepNumber
    case routine
    case extra
}

public class HomeViewController: BaseViewController<HomeViewModel>, Stepper {

    public var steps = PublishRelay<Step>()
    private var cellList: [UITableViewCell] = []
    private var cells: [HomeCell] = []
    
    private lazy var naviBar = HomeNavigationBar()

    // text 길이의 맞게 View가 유동적으로 늘어나야함
    let quotes: MotivationMessageModel = MotivationMessageModel(
        text: "가능성은 한계를 넘는다.",
        author: "Kimain"
    )

    let stepModels: StepModel = StepModel(stepCount: 112771)

    var routines: [RoutineModel] = [
        RoutineModel(exercise: "벤치", sets: 2, reps: 10),
        RoutineModel(exercise: "팔굽혀펴기", sets: 3, reps: 10),
        RoutineModel(exercise: "러닝", sets: 5, reps: 10),
        RoutineModel(exercise: "러닝", sets: 5, reps: 10)
    ]

    var extras: [ExtrasModel] = [
        ExtrasModel(image: DSKitAsset.Assets.basicProfile.image,
                    titleName: "칼로리 계산기",
                    description: "먹은 음식의 칼로리를\n계산해 보세요."),
        ExtrasModel(image: DSKitAsset.Assets.basicProfile.image,
                    titleName: "와카타임",
                    description: "지금까지 한 운동 시간을\n확인해 보세요.")
    ]

    private lazy var tableView: UITableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false

        $0.register(MotivationMessageTableViewCell.self,
                    forCellReuseIdentifier: MotivationMessageTableViewCell.identifier)
        $0.register(StepTableViewCell.self,
                    forCellReuseIdentifier: StepTableViewCell.identifier)
        $0.register(RoutineTableViewCell.self,
                    forCellReuseIdentifier: RoutineTableViewCell.identifier)
        $0.register(ExtraTableViewCell.self,
                    forCellReuseIdentifier: ExtraTableViewCell.identifier)
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20))
    }

    public override func attribute() {
        view.backgroundColor = DSKitAsset.Colors.gray25.color
        addCells()
    }

    public override func layout() {
        view.addSubviews([naviBar, tableView])
        
        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func addCells() {
        cells.append(.motivationMessage)
        cells.append(.stepNumber)
        cells.append(.routine)
        cells.append(.extra)
    }

    func routineheightForCell(with routines: [RoutineModel]) -> CGFloat {
        let cellHeight: CGFloat = 64.0
        return max(CGFloat(routines.count) * cellHeight, cellHeight) + 92
    }
    
    public override func bindViewModel() {
        super.bindViewModel()

        let myPageButtonTapped = naviBar.rightButtonTap
            .asDriver(onErrorDriveWith: .never())

        let input = HomeViewModel.Input(
            viewDidLoad: Driver.just(Void()),
            myPageButtonTapped: myPageButtonTapped
        )
        let output = self.viewModel.transform(input)

        output.isServiceAvailable
            .subscribe(onNext: { isServiceAvailable in
                print("현재 앱 서비스 사용 가능(심사 X)?: \(isServiceAvailable)")
            })
            .disposed(by: self.disposeBag)

        output.needNetworkAlert
            .subscribe(onNext: { [weak self] in
//                self?.presentNetworkAlertVC()
            })
            .disposed(by: self.disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch self.cells[indexPath.item] {
        case .motivationMessage:
            return 60.0
        case .stepNumber:
            return 120.0
        case .routine:
            return routineheightForCell(with: routines)
        case .extra:
            return 260.0
        }
    }

    public func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        switch self.cells[indexPath.item] {
        case .motivationMessage, .stepNumber, .routine, .extra:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return cells.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        switch cells[indexPath.item] {
        case .motivationMessage:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MotivationMessageTableViewCell.identifier
            ) as? MotivationMessageTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: quotes)

            return cell
        case .stepNumber:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier:
                    StepTableViewCell.identifier
            ) as? StepTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: stepModels)
            cell.layer.cornerRadius = 16.0

            return cell
        case .routine:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier:
                    RoutineTableViewCell.identifier
            ) as? RoutineTableViewCell else {
                return UITableViewCell()
            }
            cell.routines = routines
            cell.layer.cornerRadius = 16.0

            return cell
        case .extra:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ExtraTableViewCell.identifier
            ) as? ExtraTableViewCell else {
                return UITableViewCell()
            }
            cell.extras = extras

            return cell
        }
    }
}
