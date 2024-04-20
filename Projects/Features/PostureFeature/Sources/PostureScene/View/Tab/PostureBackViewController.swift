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

public class PostureBackViewController: BaseViewController<PostureBackViewModel> {

    private var firstButton = MGToggleButton(type: .bareBody)
    private var secondButton = MGToggleButton(type: .machine)

    private var headerView = UIView()

    private var postureBackTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PosturePartTableViewCell.self,
                    forCellReuseIdentifier: PosturePartTableViewCell.identifier)
    }

    private var backData: PosturePartModel = PosturePartModel(exerciseType: [], 
                                                              allExerciseData: [],
                                                              bodyExerciseData: [],
                                                              machineExerciseData: []
    )

    private var backExerciesData: [PosturePartExerciseModel] = [] {
        didSet {
            postureBackTableView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        postureBackTableView.dataSource = self
        postureBackTableView.delegate = self
    }

    public override func layout() {
        super.layout()

        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))

        headerView.addSubviews([firstButton, secondButton])

        firstButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }

        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing).offset(8.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }

        postureBackTableView.tableHeaderView = headerView
        view.addSubviews([postureBackTableView])

        postureBackTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.width.equalToSuperview().inset(8.0)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview().offset(12.0)
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()

        let firstButtonTapped = firstButton.rx.tap
            .asDriver(onErrorDriveWith: .never())

        let secondButtonTapped = secondButton.rx.tap
            .asDriver(onErrorDriveWith: .never())

        let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
        viewModel = PostureBackViewModel(useCase: useCase)

        let input = PostureBackViewModel.Input(
            firstButtonTapped: firstButtonTapped,
            secondButtonTapped: secondButtonTapped,
            getBackData:
                Observable.just(())
                .asDriver(onErrorDriveWith: .never())
        )

        _ = viewModel.transform(input, action: { output in
            output.backData
                .subscribe(onNext: { backData in
                    MGLogger.debug("backData: \(backData)")
                    self.backData = backData
                    self.backExerciesData = backData.allExerciseData
                }).disposed(by: disposeBag)

            output.backModelState
                .subscribe(onNext: { backModelState in
                    MGLogger.debug("backModelState: \(backModelState)")
                    switch backModelState {
                    case .all:
                        self.backExerciesData = self.backData.allExerciseData
                    case .body:
                        self.backExerciesData = self.backData.bodyExerciseData
                    case .machine:
                        self.backExerciesData = self.backData.machineExerciseData
                    }
                    self.postureBackTableView.reloadData()
                }).disposed(by: disposeBag)

            output.firstButtonState
                .subscribe(onNext: { firstButtonState in
                    switch firstButtonState {
                    case .checked:
                        self.firstButton.buttonYesChecked(type: .bareBody)
                    case .unChecked:
                        self.firstButton.buttonNoChecked(type: .bareBody)
                    }
                }).disposed(by: disposeBag)

            output.secondButtonState
                .subscribe(onNext: { secondButtonState in
                    switch secondButtonState {
                    case .checked:
                        self.secondButton.buttonYesChecked(type: .machine)
                    case .unChecked:
                        self.secondButton.buttonNoChecked(type: .machine)
                    }
                }).disposed(by: disposeBag)
            }
        )
    }
}

extension PostureBackViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 88
    }
}

extension PostureBackViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return backExerciesData.count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PosturePartTableViewCell.identifier,
            for: indexPath) as? PosturePartTableViewCell
        let exercise = backExerciesData[indexPath.row]
        cell?.setup(with: exercise)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

