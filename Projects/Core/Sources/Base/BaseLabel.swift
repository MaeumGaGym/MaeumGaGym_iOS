import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

open class BaseLabel: UILabel {
    public let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    public func setPretendardFont(font: UIFont) {
        // PretendardFont를 받습니다.
        self.font = font
    }
    
    public func setColor(textColor: UIColor? = .black, backgroudColor: UIColor? = .black) {
        // DSKit의 color를 받아줍니다.
        self.textColor = textColor
        self.backgroundColor = backgroudColor
    }

    public func setTextAlignmentAndNumberOfLines(alignment: NSTextAlignment, numberOfLines: Int) {
        // numberOfLines와 Alignment를 받아줍니다.
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
    }
}
