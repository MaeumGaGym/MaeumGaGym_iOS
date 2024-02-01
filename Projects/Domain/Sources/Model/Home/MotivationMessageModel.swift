import UIKit

public struct MotivationMessageModel {
    public var text: String
    public var author: String
    
    public init(text: String, author: String) {
        self.text = text
        self.author = author
    }
}
