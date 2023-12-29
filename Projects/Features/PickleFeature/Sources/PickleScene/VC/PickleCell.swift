import UIKit
import PickleFeatureInterface
import SnapKit
import Then
import DSKit
import Core
import RxSwift
import Pickle

public class PickleCell: PickleCollectionViewCell {
        
    let alertView1 = MaeumGaGymAlertOnlyTitleView(title: "링크가 복사되었어요").then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
    }
    
    let pickleInfoView = PickleInfoView()
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
    }
        
    private let hartButton = MaeumGaGymOpaqueIconButton(type: .hart)
    private let commentButton = MaeumGaGymOpaqueIconButton(type: .comment)
    private let shareButton = MaeumGaGymOpaqueIconButton(type: .share)
    private let dotButton = MaeumGaGymOpaqueIconButton(type: .dots)
    
    public override func addSubViews() {
        super.addSubViews()
        
//        self.contentView.addSubview(userProfile)
        self.contentView.addSubview(pickleInfoView)
        self.contentView.addSubviews([contentStackView, contentStackView])
        self.contentStackView.addArrangedSubviews(hartButton, commentButton, shareButton, dotButton)
    }
    
    public override func makeConstraints() {
        super.makeConstraints()
        
        pickleInfoView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(180.0)
            $0.bottom.equalToSuperview().offset(-90.0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-105.0)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        hartButton.snp.makeConstraints {
            $0.bottom.equalTo(commentButton.snp.top).offset(-24)
        }
        
        commentButton.snp.makeConstraints {
            $0.bottom.equalTo(shareButton.snp.top).offset(-24)
        }
        
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(dotButton.snp.top).offset(-24)
        }
        
        dotButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
        }
        
        hartButton.addTarget(self, action: #selector(hartButtonTapped), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        dotButton.addTarget(self, action: #selector(dotButtonTapped), for: .touchUpInside)
    }
    
    public override func configure(item: PickleItem) {
        super.configure(item: item)
        print("🖤 item: \(item)")
    }
    
    @objc private func hartButtonTapped() {
        print("하트 하트")
        alertView1.present(on: self)
    }
    
    @objc private func commentButtonTapped() {
        print("댓글 댓글")
    }
    
    @objc private func shareButtonTapped() {
        print("공유 공유")
    }
    
    @objc private func dotButtonTapped() {
        print("나머지 나머지")
    }
}
