import UIKit

public struct User {
    let id: String
    let name: String
    let accessToken: String
    
    public init(id: String, name: String, accessToken: String) {
        self.id = id
        self.name = name
        self.accessToken = accessToken
    }
}
