import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

public enum TestBannerCell {
    case banner(model: MaeumGaGymBannerModel)
}

public class BannerViewController: UIViewController {
    
    private var viewModel: MaeumGaGymBannerModel?
    private var cellList: [UITableViewCell] = []
    private var cells: [TestBannerCell] = []
    private lazy var tableView = UITableView(frame: .zero).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .systemBackground
        $0.showsHorizontalScrollIndicator = false
        $0.register(
            MaeumGaGymBannerTableViewCell.self,
            forCellReuseIdentifier: MaeumGaGymBannerTableViewCell.identifier
        )
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MaeumGaGymBannerModel()
        self.configureUI()
        self.addCells()
        
    }
}

extension BannerViewController {
    
    private func configureUI() {
        view.backgroundColor = .white

        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func addCells() {
        guard let viewModel = self.viewModel else { return }
        self.cells.append(.banner(model: viewModel))
    }
}

extension BannerViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.frame.height / 2
        } else if indexPath.row == 1 {
            return self.view.frame.height / 3.55
        } else {
            return self.view.frame.height / 2
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("클릭")
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.cells[indexPath.item] {
        case .banner:
            cell.separatorInset = UIEdgeInsets(top: 0, left: self.tableView.bounds.width, bottom: 0, right: 0)
        }
    }
}

extension BannerViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else { return UITableViewCell() }
        switch self.cells[indexPath.item] {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MaeumGaGymBannerTableViewCell.identifier
            ) as? MaeumGaGymBannerTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(viewModel)
            return cell
        }
    }
}
