import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

/// MG의 BaseLabel은 UILabel을 확장한 기본 라벨 클래스
open class BaseLabel: UILabel {
    
    /// disposeBag은 RxSwift의 메모리 관리를 위한 객체
    public let disposeBag = DisposeBag()
    
    /// 기본 초기화 함수.
    /// - Parameter frame: 라벨의 프레임.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    /// Interface Builder를 통해 생성될 때 호출되는 초기화 함수입니다.
    /// Interface Builder 사용을 지원하지 않습니다.
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 라벨의 기본 속성을 설정하는 함수입니다.
    /// 여기서 폰트, 색상 등의 기본적인 속성을 설정할 수 있습니다.
    open func attribute() {
        // Attributes configuration
    }
    
    /// 라벨의 레이아웃을 구성하는 함수입니다.
    /// SnapKit 라이브러리를 사용하여 레이아웃을 정의합니다.
    open func layout() {
        // Layout configuration using SnapKit
    }
    
    /// 라벨에 사용할 폰트를 설정합니다.
    /// - Parameter font: 설정할 폰트
    public func setPretendardFont(font: UIFont) {
        self.font = font
    }
    
    /// 라벨의 텍스트와 배경 색상을 설정합니다.
    /// - Parameters:
    ///   - textColor: 텍스트 색상
    ///   - backgroudColor: 배경 색상
    public func setColor(
        textColor: UIColor? = nil,
        backgroudColor: UIColor? = nil
    ) {
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let backgroudColor = backgroudColor {
            self.backgroundColor = backgroudColor
        }
    }

    /// 라벨의 텍스트 정렬과 줄 수를 설정합니다.
    /// - Parameters:
    ///   - alignment: 텍스트 정렬
    ///   - numberOfLines: 텍스트 줄 수
    public func setTextAlignmentAndNumberOfLines(
        alignment: NSTextAlignment? = nil,
        numberOfLines: Int? = nil
    ) {
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        
        if let lines = numberOfLines {
            self.numberOfLines = lines
        }
    }
}
