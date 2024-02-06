//
//  AuthError.swift
//  Domain
//
//  Created by 박준하 on 2/5/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//

import Foundation

public enum AuthError: Error {
    case unknown
    case googleSignInFailed
    case appleSignInFailed
    case kakaoSignInFailed
    case tokenNotFound

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error occurred."
        case .googleSignInFailed:
            return "Google Sign-In failed."
        case .appleSignInFailed:
            return "Apple Sign-In failed."
        case .kakaoSignInFailed:
            return "Kakao Sign-In failed."
        case .tokenNotFound:
            return "토큰을 찾을 수 없습니다"
        }
    }
}
