import UIKit

import MGLogger

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Domain
import Core
import DSKit

import HomeFeatureInterface
import HealthKit

public class HomeViewController: BaseViewController<HomeViewModel>, Stepper {

    private var cellList: [UITableViewCell] = []
    private var cells: [HomeCell] = []

    private lazy var naviBar = HomeNavigationBar()

    // text 길이의 맞게 View가 유동적으로 늘어나야함
    var quotes: MotivationMessageModel?
    var stepModels: StepModel?
    var routines: [RoutineModel]?
    var extras: [ExtrasModel]?

    private lazy var tableView = UITableView().then {
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
               settingButtonTapped: myPageButtonTapped,
               getStepNumber: Observable.just(()).asDriver(onErrorDriveWith: .never()),
               getMotivationMessage: Observable.just(()).asDriver(onErrorDriveWith: .never()),
               getRoutines: Observable.just(()).asDriver(onErrorDriveWith: .never()),
               getExtras: Observable.just(()).asDriver(onErrorDriveWith: .never())
           )

        _ = viewModel.transform(input, action: { output in
            output.stepNumber
                .subscribe(onNext: { stepNumber in
                    MGLogger.debug("Step Number: \(stepNumber)")
                    self.stepModels = stepNumber
                })
                .disposed(by: disposeBag)

            output.motivationMessage
                .subscribe(onNext: { message in
                    MGLogger.debug("Motivation Message: \(message)")
                    self.quotes = message
                })
                .disposed(by: disposeBag)

            output.routines
                .subscribe(onNext: { routines in
                    MGLogger.debug("Routines: \(routines)")
                    self.routines = routines
                })
                .disposed(by: disposeBag)

            output.extras
                .subscribe(onNext: { extras in
                    MGLogger.debug("Extras: \(extras)")
                    self.extras = extras
                })
                .disposed(by: disposeBag)
        })
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
            return routineheightForCell(with: routines!)
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
            cell.configure(with: quotes!)
            cell.selectionStyle = .none

            return cell
        case .stepNumber:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier:
                    StepTableViewCell.identifier
            ) as? StepTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: stepModels ?? StepModel(stepCount: 0))
            cell.layer.cornerRadius = 16.0
            cell.selectionStyle = .none

            return cell
        case .routine:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier:
                    RoutineTableViewCell.identifier
            ) as? RoutineTableViewCell else {
                return UITableViewCell()
            }
            cell.routines = routines!
            cell.layer.cornerRadius = 16.0
            cell.selectionStyle = .none

            return cell
        case .extra:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ExtraTableViewCell.identifier
            ) as? ExtraTableViewCell else {
                return UITableViewCell()
            }
            cell.extras = extras!
            cell.selectionStyle = .none

            return cell
        }
    }
}
