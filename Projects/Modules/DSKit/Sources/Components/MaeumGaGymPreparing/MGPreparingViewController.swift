import UIKit
import RxSwift
import RxCocoa
import MGLogger
import Core

open class PreparingViewController: BaseViewController<Any> {
    private let backgroundView = UIView()
    private let preparingImageView = UIImageView().then {
        $0.image = DSKitAsset.Assets.preparingImage.image
        $0.backgroundColor = .clear
    }

    private var preparingTitle: MGLabel!
    private var preparingInfo: MGLabel!

    public init(preparingType: MGPreparingType) {
        super.init("Default")
        self.preparingTitle = MGLabel(text: preparingType.title(), font: UIFont.Pretendard.titleMedium, isCenter: true)
        self.preparingInfo = MGLabel(text: preparingType.info(), font: UIFont.Pretendard.bodyMedium, isCenter: true, numberOfLineCount: 2)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubviews([backgroundView])
        backgroundView.addSubviews([preparingImageView, preparingTitle, preparingInfo])
        
        layoutSubviews()
    }

    private func layoutSubviews() {
        backgroundView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-49)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(228)
        }

        preparingImageView.snp.makeConstraints {
            $0.width.height.equalTo(120.0)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        preparingTitle.snp.makeConstraints {
            $0.top.equalTo(preparingImageView.snp.bottom).offset(24.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        preparingInfo.snp.makeConstraints {
            $0.top.equalTo(preparingTitle.snp.bottom).offset(12.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(40.0)
        }
    }
}
