import UIKit
import PickleFeatureInterface
import SnapKit
import Then
import DSKit
import Core
import RxSwift
import Pickle

public class PickleCell: PickleCollectionViewCell {
    
    private let nameLabel = UILabel().then {
        $0.textColor = .white
    }
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let hartButton = MaeumGaGymOpaqueIconButton(type: .hart)
    private let commentButton = MaeumGaGymOpaqueIconButton(type: .comment)
    private let shareButton = MaeumGaGymOpaqueIconButton(type: .share)
    private let dotButton = MaeumGaGymOpaqueIconButton(type: .dots)
    
    public override func addSubViews() {
        super.addSubViews()
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(contentStackView)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(hartButton)
        contentStackView.addArrangedSubview(commentButton)
        contentStackView.addArrangedSubview(shareButton)
        contentStackView.addArrangedSubview(dotButton)
    }
    
    public override func makeConstraints() {
        super.makeConstraints()
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(30.0)
            $0.leading.equalToSuperview().offset(30.0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-100.0)
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
        
        if let reelsItem = item as? PickleItems {
            self.nameLabel.text = reelsItem.name
        }
    }
    
    @objc private func hartButtonTapped() {
        print("하트 하트")
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
