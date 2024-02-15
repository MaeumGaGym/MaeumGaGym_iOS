//
//  DSHorizontalPickerViewController.swift
//  DSKit
//
//  Created by 박준하 on 2/14/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class DSHorizontalPickerViewController: UIViewController {
    
    private lazy var hPickerView: HorizontalPickerView = {
        let view = HorizontalPickerView()
        view.pickerSelectValue = 0
        view.delegate = self
        view.backgroundColor = .green
        
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        view.backgroundColor = .red
    }

}

extension DSHorizontalPickerViewController: HorizontalPickerViewDelegate {
    
    public func didLevelChanged(selectedLevel: Int) {
        print("변경된 값은?:\(selectedLevel)")
    }
    
}

extension DSHorizontalPickerViewController {
    
    func setUpLayout() {
        
        view.addSubview(hPickerView)
        hPickerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.center.equalToSuperview()
            $0.height.equalTo(120)
        }
        
    }
}
