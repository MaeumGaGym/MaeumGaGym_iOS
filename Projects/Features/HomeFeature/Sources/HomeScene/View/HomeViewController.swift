import UIKit
import SnapKit
import RxFlow
import RxCocoa
import RxSwift
import Core
import DSKit

enum HomeCell {
    case banner
}

public class HomeViewController: UIViewController, Stepper {

    public var steps = PublishRelay<Step>()
    private var cellList: [UITableViewCell] = []
    private var cells: [HomeCell] = []

    //text 길이의 맞게 View가 유동적으로 늘어나야함
    let quotes: MotivationMessageModel = MotivationMessageModel(
        text: "가능성은 한계를 넘는다.",
        author: "Kimain"
    )

    public let disposeBag = DisposeBag()

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
        return tableView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        self.view.backgroundColor = .systemBackground
        configureUI()
        addCells()
    }

    private func configureUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    private func addCells() {
        self.cells.append(.banner)
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else if indexPath.row == 1 {
            return self.view.frame.height / 3.55
        } else if indexPath.row == 3 {
            return self.view.frame.height / 2.6
        } else {
            return self.view.frame.height / 2
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.cells[indexPath.item] {
        case .banner:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        case .banner:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MotivationMessageTableViewCell.identifier
            ) as? MotivationMessageTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: quotes)
            return cell
        }
    }
}
