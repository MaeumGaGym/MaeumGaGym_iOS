import Foundation

import MGLogger

public struct TokenManagerImpl: TokenManager {
    
    private let keychainClass = kSecClassGenericPassword
    
    public init() {}
     
    public func get(key: KeychainType) -> String? {
        
        let query: [CFString: Any] = [
            kSecClass: keychainClass,
            kSecAttrAccount: key.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            MGLogger.debug("키체인 항목을 찾을 수 없음")
            return nil
        }
        guard status == errSecSuccess else {
            MGLogger.debug("키체인을 읽을 수 없음")
            return nil
        }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data,
              let token = String(data: data, encoding: .utf8) else { return nil }
        
        MGLogger.debug("토큰 가져오기: \(token)")
        
        return token
    }
    
    @discardableResult
    public func save(token: String, with key: KeychainType) -> Bool {
        
        guard let tokenData = token.data(using: .utf8) else { return false }
        
        let query: [CFString: Any] = [
            kSecClass: keychainClass,
            kSecAttrAccount: key.rawValue,
            kSecValueData: tokenData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        MGLogger.debug("토큰 저장 상태: \(status)")
        
        switch status {
        case errSecSuccess:
            MGLogger.debug("save requested token: \(token), saved token: \(String(describing: get(key: key)))")
            return true
        case errSecDuplicateItem:
            return update(token: token, with: key)
        default:
            return false
        }
    }
    
    @discardableResult
    public func update(token: String, with key: KeychainType) -> Bool {
        
        guard let tokenData = token.data(using: .utf8) else { return false }

        let searchQuery: [CFString: Any] = [
            kSecClass: keychainClass,
            kSecAttrAccount: key.rawValue
        ]
        
        let updateQuery: [CFString: Any] = [
            kSecAttrAccount: key.rawValue,
            kSecValueData: tokenData
        ]
        
        let status = SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
        
        MGLogger.debug("토큰 상태 업데이트: \(status)")
        
        return status == errSecSuccess
        
        switch status {
        case errSecSuccess:
            MGLogger.debug("요청한 토큰 업데이트: \(token), 업데이트된 토큰: \(String(describing: get(key: key)))")
            return true
        case errSecItemNotFound:
            return save(token: token, with: key)
        default:
            return true
        }
    }
    
    @discardableResult
    public func delete(key: KeychainType) -> Bool {
        
        let query: [CFString: Any] = [
            kSecClass: keychainClass,
            kSecAttrAccount: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        MGLogger.debug("빈 토큰 확인: \(String(describing: get(key: key)))가 비어 있나요?")
        MGLogger.debug("토큰 상태 삭제: \(status)")
        
        return status == errSecSuccess
    }
}
