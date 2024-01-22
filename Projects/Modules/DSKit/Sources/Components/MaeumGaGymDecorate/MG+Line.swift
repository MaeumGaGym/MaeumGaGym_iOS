import UIKit
import Then
import SnapKit
import Core

open class MaeumGaGymLine: BaseView {
    private let lineView = UIView()
    
    public init(
        lineColor: UIColor? = DSKitAsset.Colors.gray50.color,
        lineWidth: Double? = 390.0,
        lineHeight: Double? = 2.0
    ) {
        super.init(frame: .zero)
        
        setupUI(lineColor: lineColor, lineWidth: lineWidth, lineHeight: lineHeight)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layout() {
        super.layout()
        
        self.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupUI(
        lineColor: UIColor?,
        lineWidth: Double?,
        lineHeight: Double?
    ) {
        lineView.backgroundColor = lineColor
        snp.makeConstraints {
            $0.width.equalTo(lineWidth!)
            $0.height.equalTo(lineHeight!)
        }
    }
}
