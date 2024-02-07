import Foundation

public protocol TokenManager {
        
    func get(key: KeychainType) -> String?
    
    @discardableResult
    func save(token: String, with key: KeychainType) -> Bool
    
    @discardableResult
    func update(token: String, with key: KeychainType) -> Bool
    
    @discardableResult
    func delete(key: KeychainType) -> Bool
}
