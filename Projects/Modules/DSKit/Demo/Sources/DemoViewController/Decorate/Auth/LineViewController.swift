import UIKit
import DSKit
import SnapKit
import Then

open class LineViewController: UIViewController {
    
    private let decorateLine1 = MaeumGaGymLine(
        lineColor: DSKitAsset.Colors.gray50.color,
        lineWidth: 390.0,
        lineHeight: 2.0
    )
    private let decorateLine2 = MaeumGaGymLine(
        lineColor: DSKitAsset.Colors.red700.color,
        lineWidth: 390.0,
        lineHeight: 10.0
    )
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        [
            decorateLine1,
            decorateLine2
        ].forEach { view.addSubview($0) }
        
        decorateLine1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }
        
        decorateLine2.snp.makeConstraints {
            $0.top.equalTo(decorateLine1.snp.bottom).offset(50.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)   
        }
    }
}
