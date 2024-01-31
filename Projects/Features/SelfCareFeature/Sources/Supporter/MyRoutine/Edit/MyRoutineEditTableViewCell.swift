import UIKit

import SnapKit
import Then

import Core
import DSKit

public class MyRoutineEditTableViewCell: BaseTableViewCell {
    static let identifier: String = "MyRoutineEditTableViewCell"
    
    private var containerView = UIView()
    
    private var exerciseImage = UIImageView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
        $0.layer.cornerRadius = 40.0
        $0.contentMode = .scaleToFill
    }
    
    private var exerciseNameLabel = UILabel().then {
        $0.font = UIFont.Pretendard.bodyMedium
    }
    
    
    
    
}
