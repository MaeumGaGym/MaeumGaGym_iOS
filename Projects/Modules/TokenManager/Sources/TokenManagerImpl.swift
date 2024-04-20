import Foundation

import MGLogger

public struct TokenManagerImpl: TokenManager {
    
    private let keychainClass = kSecClassGenericPassword
    
    public init() {}
    
    /**
     토큰을 불러옵니다.
     - Parameters:
     - key: 토큰을 구분할 KeychainType 키입니다.
     - Returns: 토큰을 성공적으로 불러오면 String을 반환합니다.
     */
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
    
    /**
     토큰을 Keychain에 저장합니다. 만약 해당 키에 이미 토큰이 저장되어 있다면, 새로운 토큰으로 업데이트합니다.
     - Parameters:
     - token: 저장할 토큰 문자열입니다. (String)
     - key: 토큰을 구분할 KeychainType 키입니다.
     - Returns: 토큰 저장 성공 여부를 Bool 값으로 반환합니다. 성공하면 true, 실패하면 false를 반환합니다.
     */
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
    
    /**
     토큰을 업데이트합니다.
     > 이 함수는 Keychain에 저장된 특정 키의 토큰을 업데이트합니다. 만약 해당 키에 대한 토큰이 존재하지 않는 경우, 새로운 토큰을 저장합니다. 함수는 업데이트하려는 토큰의 문자열과 KeychainType 키를 매개변수로 받고, 토큰 저장 작업의 성공 여부를 나타내는 불리언 값을 반환합니다 (성공 시 true, 실패 시 false).
     - Parameters:
     - token: 저장할 토큰 문자열입니다. (String)
     - key: 토큰을 구분할 KeychainType 키입니다.
     
     - Returns: 토큰 저장 성공 여부를 Bool 값으로 반환합니다. 성공하면 true, 실패하면 false를 반환합니다.
     **/
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
    
    /**
     토큰을 삭제합니다.
     - Parameters:
     - key: 토큰을 구분할 KeychainType 키입니다.
     - Returns: 저장된 키를 삭제하고 성공여부로를 Bool로 반환
     **/
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
