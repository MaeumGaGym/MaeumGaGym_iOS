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

public class HomeViewController: BaseViewController<Any>, Stepper {

    public var steps = PublishRelay<Step>()
    private var cellList: [UITableViewCell] = []
    private var cells: [HomeCell] = []
    
    private lazy var naviBar = MainNavigationBar()

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = DSKitAsset.Colors.gray25.color
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            MotivationMessageTableViewCell.self,
            forCellReuseIdentifier: MotivationMessageTableViewCell.identifier
        )
        tableView.register(
            StepTableViewCell.self,
            forCellReuseIdentifier: StepTableViewCell.identifier)
        tableView.register(
            RoutineTableViewCell.self,
            forCellReuseIdentifier: RoutineTableViewCell.identifier)
        tableView.register(ExtraTableViewCell.self,
                           forCellReuseIdentifier: ExtraTableViewCell.identifier)
        return tableView
    }()

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.isNavigationBarHidden = true
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20))
    }

    public override func attribute() {
        self.title = "asdfasdfas"
        self.view.backgroundColor = DSKitAsset.Colors.gray25.color

        addCells()
    }

    public override func layout() {
        self.view.addSubviews([naviBar, tableView])
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func addCells() {
        self.cells.append(.motivationMessage)
        self.cells.append(.stepNumber)
        self.cells.append(.routine)
        self.cells.append(.extra)
    }

    func heightForCell(with routines: [RoutineModel]) -> CGFloat {
        let cellHeight: CGFloat = 64.0
        return max(CGFloat(routines.count) * cellHeight, cellHeight) + 92
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cells[indexPath.item] {
        case .motivationMessage:
            return 60.0
        case .stepNumber:
            return 120.0
        case .routine:
            return heightForCell(with: routines)
        case .extra:
            return 260.0
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.cells[indexPath.item] {
        case .motivationMessage:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 24, right: 20)
        case .stepNumber:
            cell.separatorInset = UIEdgeInsets(top: 24, left: 20, bottom: 0, right: 20)
        case .routine:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .extra:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.cells[indexPath.item] {
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
