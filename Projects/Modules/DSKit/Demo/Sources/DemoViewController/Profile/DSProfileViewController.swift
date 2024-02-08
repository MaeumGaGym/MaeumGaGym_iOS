import Foundation
import DSKit
import UIKit
import SnapKit
import RxCocoa
import RxSwift

public class DSProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    lazy var introProfile = MGProfileView(
        profileImage: MGProfileImage(type: .custom, customImage: nil),
        profileType: .intro
    )

    lazy var smallProfile = MGProfileView(
        profileImage: MGProfileImage(type: .custom, customImage: nil),
        profileType: .smallProfile
    )

    lazy var middleProfile = MGProfileView(
        profileImage: MGProfileImage(type: .custom, customImage: nil),
        profileType: .middleProfile
    )

    lazy var bigProfile = MGProfileView(
        profileImage: MGProfileImage(type: .custom, customImage: nil),
        profileType: .bigProfile
    )

    public override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    func attribute() {
        view.backgroundColor = .white
    }

    func layout() {
        [
            introProfile,
            smallProfile,
            middleProfile,
            bigProfile
        ].forEach { view.addSubview($0) }
        
        introProfile.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        smallProfile.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(introProfile.snp.bottom).offset(20.0)
        }

        middleProfile.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(smallProfile.snp.bottom).offset(20.0)
        }

        bigProfile.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(middleProfile.snp.bottom).offset(20.0)
        }
    }
}
