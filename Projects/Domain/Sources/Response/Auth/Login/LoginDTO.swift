import Foundation

public struct LoginResponseDTO: Decodable {
    public let status: Int
    public let accessToken: String
    public let refreshToken: String
}

public struct SignupResponseDTO: Decodable {
    public let status: Int
}

public struct RecoveryResponseDTO: Decodable {
    public let status: Int
}

enum AuthErrorType: Error {
    case error400
    case error401
    case error404
    case error409
    case error500
}
