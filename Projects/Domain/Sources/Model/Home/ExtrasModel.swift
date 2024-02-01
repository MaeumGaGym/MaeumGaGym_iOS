import UIKit

public struct ExtrasModel {
    public var image: UIImage
    public var titleName: String
    public var description: String
    
    public init(image: UIImage, titleName: String, description: String) {
        self.image = image
        self.titleName = titleName
        self.description = description
    }
}
