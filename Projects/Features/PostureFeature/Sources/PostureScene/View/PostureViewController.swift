
import UIKit
import SnapKit
import Then
import Core
import RxFlow
import RxCocoa
import RxSwift
import DSKit
import CSLogger
import PostureFeatureInterface

public class PostureViewController: BaseViewController<PostureViewModel> {
    
    private let titleView = PostureRecommandTitleView(text: "맨몸운동", image: DSKitAsset.Assets.arm.image)
    
    
    private var checkButton = MaeumGaGymCheckButton(text: "확인")
    
    public override func layout() {
        self.view.addSubviews([titleView])
        
    }
}

