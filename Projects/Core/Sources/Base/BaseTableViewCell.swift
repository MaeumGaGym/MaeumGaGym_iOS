import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

open class BaseTableViewCell: UITableViewCell {
    
    public let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public let contentCornerRadius: CGFloat = 16.0

    public var disposeBag = DisposeBag()
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
        setupCornerRadiusAndBackground()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        addViews()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    open func setupCornerRadiusAndBackground() {
         contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
         contentView.backgroundColor = .white
         contentView.layer.cornerRadius = contentCornerRadius
     }
    
    open func commonInit() {
        
    }
    
    open func attribute() {
        // 부가적인 것을 여기에 넣습니다.
    }
    
    open func layout() {
        // 서브뷰를 구성하고 SnapKit을 사용해서 layout을 하는 함수입니다.
    }
    
    open func addViews() {
        // view 추가 함수
    }
}
