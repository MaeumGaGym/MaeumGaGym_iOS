//
//  AlbumEmptyView.swift
//  SelfCareFeatureInterface
//
//  Created by 박준하 on 12/26/23.
//  Copyright © 2023 MaeumGaGym-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DSKit

public enum AlbumEmptyType {
    case album
    case picture
}

public class AlbumEmptyView: UIView {
    
    private lazy var emptyDescription = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = DSKitAsset.Colors.gray200.color
    }
    
    private lazy var button = UIButton().then {
        $0.backgroundColor = DSKitAsset.Colors.gray200.color
        $0.makeRounded(radius: 28)
    }
    
    var viewType: AlbumEmptyType?
    
    public init(viewType: AlbumEmptyType) {
        self.viewType = viewType
        super.init(frame: .zero)
        layout()
        setText(type: viewType)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews([emptyDescription, button])
        
        emptyDescription.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.width.equalTo(121)
            $0.centerX.bottom.equalToSuperview()
        }
    }
    
    private func setText(type: AlbumEmptyType) {
        switch type {
        case .album:
            emptyDescription.text = "앨범이 없습니다.\n지금 앨범을 만들어 기록해보세요."
            button.setTitle("앨범 생성", for: .normal)
        case .picture:
            emptyDescription.text = "저장된 사진이 없습니다.\n지금 사진을 찍어 기록해보세요."
            button.setTitle("사진 촬영", for: .normal)
        }
    }
}
