import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

/// BaseView는 UIView를 확장하여 범용적으로 사용할 수 있는 기본 뷰 클래스입니다.
open class BaseView: UIView {
    public let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
        bind()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 뷰의 기본 속성을 설정하는 함수입니다.
    open func attribute() { }
    
    /// 이 함수에서는 각 서브뷰의 위치와 크기를 결정합니다.
    open func layout() { }

    /// 이 함수에서는 RxCocoa를 활용하여 이벤트 처리 및 데이터 스트림을 관리합니다.
    open func bind() { }
}
