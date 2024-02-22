import UIKit
import Data

import MGLogger
import MGNetworks

import RxSwift
import RxCocoa
import RxFlow

import Then
import SnapKit

import Core
import DSKit

import Domain

enum SelfCareCell {
    case introductMessage
    case profile
    case selfCare
}

public class SelfCareHomeViewController: BaseViewController<SelfCareHomeViewModel> {

    private var cellList: [UITableViewCell] = []
    private var cells: [SelfCareCell] = []

    var introducts = SelfCareIntroductModel(image: DSKitAsset.Assets.selfCareMainImage.image,
                                            mainText: "자기관리",
                                            subText: "나만의 루틴과 목표를 설정하여\n자기관리에 도전해보세요.")

    var profiles = SelfCareProfileModel(userImage: DSKitAsset.Assets.basicProfile.image,
                                        userName: "박준하",
                                        userTimer: 123,
                                        userBage: DSKitAsset.Assets.bage1.image)

    var menus = [SelfCareMenuModel(menuImage: DSKitAsset.Assets.selfCareMenuMyRoutine.image, menuName: "내루틴"),
                         SelfCareMenuModel(menuImage: DSKitAsset.Assets.selfCareGoul.image, menuName: "목표"),
                         SelfCareMenuModel(menuImage: DSKitAsset.Assets.selfCareFood.image, menuName: "식단"),
                         SelfCareMenuModel(menuImage: DSKitAsset.Assets.selfCareOunwan.image, menuName: "오운완")]

    private lazy var tableView: UITableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(SelfCareIntroductTableViewCell.self,
                    forCellReuseIdentifier: SelfCareIntroductTableViewCell.identifier)
        $0.register(SelfCareProfileTableViewCell.self, forCellReuseIdentifier: SelfCareProfileTableViewCell.identifier
        )
        $0.register(SelfCareMenuTableViewCell.self, forCellReuseIdentifier: SelfCareMenuTableViewCell.identifier
        )
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()

        navigationController?.isNavigationBarHidden = true
    }

    public override func attribute() {
        super.attribute()

        view.backgroundColor = DSKitAsset.Colors.gray25.color
        addCells()
    }

    public override func layout() {
        view.addSubviews([tableView])

        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func addCells() {
        cells.append(.introductMessage)
        cells.append(.profile)
        cells.append(.selfCare)
    }

    func menuheightForCell(with menus: [SelfCareMenuModel]) -> CGFloat {
        let cellHeight: CGFloat = 64.0
        return max(CGFloat(menus.count) * cellHeight, cellHeight) + 92
    }

}

extension SelfCareHomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.item] {
        case .introductMessage:
            return 232
        case .profile:
            return 80
        case .selfCare:
            return menuheightForCell(with: menus)
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cells[indexPath.item] {
        case .introductMessage, .profile, .selfCare:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension SelfCareHomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.item] {
        case .introductMessage:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SelfCareIntroductTableViewCell.identifier
            ) as? SelfCareIntroductTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: introducts)

            return cell
        case .profile:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SelfCareProfileTableViewCell.identifier
            ) as? SelfCareProfileTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: profiles)

            return cell
        case .selfCare:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SelfCareMenuTableViewCell.identifier
            ) as? SelfCareMenuTableViewCell else {
                return UITableViewCell()
            }
            cell.menus = menus

            return cell
        }
    }
}
