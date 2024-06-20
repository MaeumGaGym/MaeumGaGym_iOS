import UIKit

import RxSwift
import RxCocoa
import RxFlow

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGLogger
import Data
import MGNetworks

import SelfCareFeatureInterface

public class SelfCareTargetMainViewController: BaseViewController<SelfCareTargetMainViewModel> {
    
    private let loadTargetRelay = PublishRelay<Void>()
    private let deleteRelay = PublishRelay<Int>()
    private let editRelay = PublishRelay<Int>()

    private var targetMainModel = SelfCareTargetMainModel(targetList: [])

    private var headerView = UIView()
    private var containerView = UIView()

    let alert = MGAlertOnlyTitleView(title: "목표를 삭제했어요.")
    private let navBar = SelfCareProfileNavigationBar()

    private let targetTitleLabel = MGLabel(
        font: UIFont.Pretendard.titleLarge,
        textColor: .black,
        isCenter: false
    )

    private let targetSubTitleLabel = MGLabel(
        font: UIFont.Pretendard.bodyMedium,
        textColor: DSKitAsset.Colors.gray600.color,
        isCenter: false,
        numberOfLineCount: 1
    )

    private var targetMainTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.scrollsToTop = true
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(
            TargetMainTableViewCell.self,
            forCellReuseIdentifier: TargetMainTableViewCell.identifier
        )
    }

    private var plusTargetButton = SelfCareButton(type: .plusTarget)

    public override func attribute() {
        super.attribute()

        view.backgroundColor = .white
        loadTargetRelay.accept(())

        targetTitleLabel.changeText(text: "목표")
        targetSubTitleLabel.changeText(text: "나만의 목표를 세워보세요.")
        targetMainTableView.delegate = self
        targetMainTableView.dataSource = self
    }
    public override func layout() {
        super.layout()

        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 124.0))
        view.addSubview(headerView)

        headerView.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        containerView.addSubviews([targetTitleLabel, targetSubTitleLabel])

        targetTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48.0)
        }

        targetSubTitleLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }

        view.addSubviews([
            alert,
            targetMainTableView,
            plusTargetButton,
            navBar
        ])

        alert.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        navBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        targetMainTableView.tableHeaderView = headerView
        targetMainTableView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        plusTargetButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-54.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(58.0)
        }
    }
    public override func bindActions() {
        plusTargetButton.rx.tap
            .bind(onNext: { [weak self] in
                let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: DefaultSelfCareService()))
                let viewModel = SelfCareAddTargetViewModel(useCase: useCase)
                self?.navigationController?.pushViewController(SelfCareAddTargetViewController(viewModel), animated: true)
            }).disposed(by: disposeBag)

    }
    public override func bindViewModel() {
        let input = SelfCareTargetMainViewModel.Input(
            getTargetMainData: loadTargetRelay.asDriver(onErrorJustReturn: ()),
            deleteTarget: deleteRelay.asDriver(onErrorJustReturn: 0),
            editTarget: editRelay.asDriver(onErrorJustReturn: 0),
            popVCButton: navBar.leftButtonTap.asDriver()
        )

        _ = viewModel.transform(input, action: { output in
            output.targetMainData
                .subscribe(onNext: { targetMainData in
                    MGLogger.debug("targetMainData: \(targetMainData)")
                    self.targetMainModel = targetMainData
                    self.targetMainTableView.reloadData()
                }).disposed(by: disposeBag)
        })
    }
}

extension SelfCareTargetMainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == targetMainModel.targetList.count + 1 {
            return 100
        } else {
            return 94
        }
    }
}

extension SelfCareTargetMainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        targetMainModel.targetList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == targetMainModel.targetList.count {
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TargetMainTableViewCell.identifier,
                for: indexPath) as? TargetMainTableViewCell
            let model = targetMainModel.targetList[indexPath.row]
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            cell?.dotButtonTap
                .bind { [weak self] in
                    let modal = MGSelfCareTargetBottomSheetAlertView(
                        editButtonTap: {
                            print("editButtonTapped")
                            self?.loadTargetRelay.accept(())
                            self?.dismiss(animated: true, completion: {
                                self?.editRelay.accept(self?.targetMainModel.targetList[indexPath.row].id ?? 0)
                            })
                        },
                        deleteButtonTap: {
                            print("deleteButtonTapped")
                            self?.deleteRelay.accept(self?.targetMainModel.targetList[indexPath.row].id ?? 0)
                            self?.loadTargetRelay.accept(())
                            self?.alert.present(on: self?.view ?? UIView())
                        }
                    )
                    let customDetents = UISheetPresentationController.Detent.custom(
                        identifier: .init("sheetHeight")
                    ) { _ in
                        return 153
                    }

                    if let sheet = modal.sheetPresentationController {
                        sheet.detents = [customDetents]
                        sheet.prefersGrabberVisible = true
                    }
                    self?.present(modal, animated: true)
                }.disposed(by: cell?.disposeBag ?? DisposeBag())
            return cell ?? UITableViewCell()
        }
    }
}

extension SelfCareTargetMainViewController {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let useCase = DefaultSelfCareUseCase(repository: SelfCareRepository(networkService: DefaultSelfCareService()))
        let viewModel = SelfCareDetailTargetViewModel(useCase: useCase)
        let vc = SelfCareDetailTargetViewController(viewModel)
        vc.targetID = self.targetMainModel.targetList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
