import UIKit

import SnapKit
import Then

import Core
import DSKit

open class DSTagLabelVC: UIViewController {
    private let tagLabel1 = MGTagLabel(text: "맨몸")
    private let tagLabel2 = MGTagLabel(text: "가슴")

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    func layout() {
        
        view.addSubviews([tagLabel1, tagLabel2])

        tagLabel1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)   
        }

        tagLabel2.snp.makeConstraints {
            $0.top.equalTo(tagLabel1.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)      
        }
    }
}
