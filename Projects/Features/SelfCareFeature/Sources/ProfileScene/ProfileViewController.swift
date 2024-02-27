import UIKit
import SelfCareFeatureInterface

import MGNetworks
import Domain

import DSKit
import Core

final public class SelfCareProfileViewController: BaseViewController<ProfileEditViewModel> {
    private lazy var navBar = SelfCareProfileNavigationBar()

    private lazy var userProfileImageView = MGProfileView(
        profileImage: MGProfileImage(type: .custom,
                                     customImage: SelfCareResourcesService.Assets.baseProfile),
        profileType: .maxProfile)

    private lazy var userNameLabel = MGLabel(text: "박준하",
                                             font: UIFont.Pretendard.titleMedium,
                                             textColor: .black)
    private var bageView = SelfCareBageView()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    public override func configureNavigationBar() {
        super.configureNavigationBar()

        navigationController?.isNavigationBarHidden = true
    }

    public override func layout() {
        super.layout()

        view.addSubviews([navBar,
                          userProfileImageView,
                          userNameLabel,
                          bageView
                         ])

        navBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        userProfileImageView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(16.0)
            $0.leading.equalTo(userProfileImageView.snp.leading)
        }

        bageView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(32.0)
            $0.width.equalTo(390)
            $0.centerX.equalToSuperview()
        }
    }
}
