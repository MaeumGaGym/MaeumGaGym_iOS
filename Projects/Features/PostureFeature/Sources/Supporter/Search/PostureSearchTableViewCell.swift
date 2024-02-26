import UIKit

import SnapKit
import Then

import DSKit
import Core
import MGNetworks

public class PostureSearchTableViewCell: UITableViewCell {

    public static let identifier: String = PostureResourcesService.Identifier.postureSearchTableViewCell

    private var searchImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = PostureResourcesService.Colors.gray50
        $0.layer.cornerRadius = 8.0
    }
    
    private var exerciseNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private var exercisePartLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
        $0.backgroundColor = PostureResourcesService.Colors.gray400
        $0.textAlignment = .left
    }
    
    public func setup(image: UIImage, name: String, part: String) {
        searchImageView.image = image
        exerciseNameLabel.text = name
        exercisePartLabel.text = part
        
        addViews()
        setupViews()
    }
    
    private func addViews() {
        addSubviews([searchImageView, exerciseNameLabel, exercisePartLabel])
    }
    
    private func setupViews() {
        searchImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.height.equalTo(64.0)
        }
        
        exerciseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26.0)
            $0.leading.equalTo(searchImageView.snp.trailing).offset(18.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        exercisePartLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseNameLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(searchImageView.snp.trailing).offset(18.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }
    }
    
    
    
    
    
    
}
