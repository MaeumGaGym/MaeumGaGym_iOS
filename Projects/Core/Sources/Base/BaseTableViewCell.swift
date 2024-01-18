import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

open class BaseTableViewCell: UITableViewCell {
    public let disposeBag = DisposeBag()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
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
    
    open func addViews() {
        
    }
}
