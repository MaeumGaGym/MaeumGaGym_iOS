////
////  KakaoOauthTestViewController.swift
////  AuthFeatureInterface
////
////  Created by 박준하 on 2/5/24.
////  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//import Then
//import SnapKit
//
//import RxSwift
//import RxCocoa
//
//import KakaoSDKAuth
//import KakaoSDKUser
//
//public class KakaoOauthTestViewController: UIViewController {
//
//    public var testKakaoButton = UIButton().then {
//        $0.backgroundColor = .black
//    }
//
//    public var testLabel = UILabel().then {
//        $0.textColor = .green
//        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
//    }
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .red
//
//        view.addSubview(testKakaoButton)
//
//        testKakaoButton.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//            $0.height.width.equalTo(100.0)
//        }
//
//        testKakaoButton.rx
//            .tap.bind {
//                self.testButtonDidTap()
//            }
//    }
//
//    func testButtonDidTap() {
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("oauthToken: \(oauthToken)")
//                    print("loginWithKakaoTalk() success.")
//                    
//                    self.kakaoGetUserInfo()
//                }
//            }
//        }
//    }
//    
//    private func kakaoGetUserInfo() {
//        UserApi.shared.me() { (user, error) in
//            if let error = error {
//                print(error)
//            }
//            
//            let userName = user?.kakaoAccount?.name
//            
//            let contentText =
//            "user name : \(userName)"
//            
//            print("user - \(user)")
//            
//            self.testLabel.text = contentText
//        }
//    }
//}
