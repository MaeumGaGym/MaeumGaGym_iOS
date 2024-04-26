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

import PostureFeatureInterface

public class PostureChestViewController: BaseViewController<PostureChestViewModel> {

    private var firstButton = MGToggleButton(type: .bareBody)
    private var secondButton = MGToggleButton(type: .machine)

    private var headerView = UIView()

    private var postureChestTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PosturePartTableViewCell.self,
                    forCellReuseIdentifier: PosturePartTableViewCell.identifier)
    }

    private var chestData: PosturePartModel = PosturePartModel(exerciseType: [], 
                                                               allExerciseData: [],
                                                               bodyExerciseData: [],
                                                               machineExerciseData: []
    )

    private var chestExerciesData: [PosturePartExerciseModel] = [] {
        didSet {
            postureChestTableView.reloadData()
        }
    }

    public override func attribute() {
        super.attribute()

        postureChestTableView.dataSource = self
        postureChestTableView.delegate = self
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

        postureChestTableView.tableHeaderView = headerView
        view.addSubview(postureChestTableView)

        postureChestTableView.snp.makeConstraints {
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

//        let useCase = DefaultPostureUseCase(repository: PostureRepository(networkService: PostureService()))
//        viewModel = PostureChestViewModel(useCase: useCase)

        let input = PostureChestViewModel.Input(
            firstButtonTapped: firstButtonTapped,
            secondButtonTapped: secondButtonTapped,
            getChestData:
                Observable.just(())
                .asDriver(onErrorDriveWith: .never())
        )

        _ = viewModel.transform(input, action: { output in
            output.chestData
                .subscribe(onNext: { chestData in
                    MGLogger.debug("Chest Data: \(chestData)")
                    self.chestData = chestData
                    self.chestExerciesData = chestData.allExerciseData
                }).disposed(by: disposeBag)

            output.chestModelState
                .subscribe(onNext: { chestModelState in
                    MGLogger.debug("Chest Model State: \(chestModelState)")
                    switch chestModelState {
                    case .all:
                        self.chestExerciesData = self.chestData.allExerciseData
                    case .body:
                        self.chestExerciesData = self.chestData.bodyExerciseData
                    case .machine:
                        self.chestExerciesData = self.chestData.machineExerciseData
                    }
                    self.postureChestTableView.reloadData()
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

extension PostureChestViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 88
    }
}

extension PostureChestViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return chestExerciesData.count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PosturePartTableViewCell.identifier,
            for: indexPath) as? PosturePartTableViewCell
        let exercise = chestExerciesData[indexPath.row]
        cell?.setup(with: exercise)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

