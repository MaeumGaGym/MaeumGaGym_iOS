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
