import Foundation

public struct SignupRequestDTO: Codable {
    public let oauthToken: String
    public let nickname: String
}

public struct LoginRequestDTO: Codable {
    public let oauthToken: String
}

public struct RecoveryRequestDTO: Codable {
    public let oauthToken: String
}

public struct SignupResponseDTO: Codable {
    public let status: Int
}

public struct LoginResponseDTO: Codable {
    public let status: Int
    public let accessToken: String
    public let refreshToken: String
}

public struct RecoveryResponseDTO: Codable {
    public let status: Int
}

public struct DeleteRequestDTO: Codable {
    public let accessToken: String
}

public struct DeleteResponseDTO: Codable {
    public let status: Int
}

public struct tokenRefreshRequestDTO: Codable {
    public let refreshToken: String
}

public struct tokenRefreshResponseDTO: Codable {
    public let status: Int
    public let accessToken: String
    public let refreshToken: String
}

public struct CheckNicknameRequestDTO: Codable {
    public let nickname: String
}

public struct CheckNicknameResponseDTO: Codable {
    public let status: Int
}

public enum AuthErrorType: Error {
    case notFound400
    case notInt
}
