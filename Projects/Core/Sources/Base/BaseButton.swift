import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

open class BaseButton: UIButton {
    public let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
        buttonAction()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func attribute() {
        // 부가적인 것을 여기에 넣습니다.
    }
    
    open func layout() {
        // 서브뷰를 구성하고 SnapKit을 사용해서 layout을 하는 함수입니다.
    }
    
    open func buttonAction() {
        // 버튼을 클릭했을 때의 이벤트를 넣습니다
    }
}
