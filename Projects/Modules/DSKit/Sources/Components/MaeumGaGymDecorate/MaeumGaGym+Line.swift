import UIKit
import Then
import SnapKit

open class MaeumGaGymLine: UIView {
    private let lineView = UIView()
    
    public init(
        lineColor: UIColor? = DSKitAsset.Colors.gray50.color,
        lineWidth: Double? = 390.0,
        lineHeight: Double? = 2.0
    ) {
        super.init(frame: .zero)
        
        lineView.backgroundColor = lineColor
        snp.makeConstraints {
            $0.width.equalTo(lineWidth!)
            $0.height.equalTo(lineHeight!)
        }
        
        setupContraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraints() {
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
