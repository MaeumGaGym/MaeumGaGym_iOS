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
}

public class HomeViewController: BaseViewController<Any>, Stepper {

    public var steps = PublishRelay<Step>()
    private var cellList: [UITableViewCell] = []
    private var cells: [HomeCell] = []

    // text 길이의 맞게 View가 유동적으로 늘어나야함
    let quotes: MotivationMessageModel = MotivationMessageModel(
        text: "가능성은 한계를 넘는다.",
        author: "Kimain"
    )
    
    let stepModels: StepModel = StepModel(stepCount: 2771)

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(
            MotivationMessageTableViewCell.self,
            forCellReuseIdentifier: MotivationMessageTableViewCell.identifier
        )
        tableView.register(StepTableViewCell.self, forCellReuseIdentifier: StepTableViewCell.identifier)
        return tableView
    }()

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20))
    }

    public override func attribute() {
        self.title = "Home"
        self.view.backgroundColor = .systemBackground

        addCells()
    }

    public override func layout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func addCells() {
        self.cells.append(.motivationMessage)
        self.cells.append(.stepNumber)
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60.0
        } else if indexPath.row == 1 {
            return 80.0
        } else if indexPath.row == 3 {
            return self.view.frame.height / 2.6
        } else {
            return self.view.frame.height / 2
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.cells[indexPath.item] {
        case .motivationMessage:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 24, right: 20)
        case .stepNumber:
            cell.separatorInset = UIEdgeInsets(top: 24, left: 20, bottom: 0, right: 20)
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
            return cell
        }
    }
}
