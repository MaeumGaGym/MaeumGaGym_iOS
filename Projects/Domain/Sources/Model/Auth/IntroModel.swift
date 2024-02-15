import UIKit

public struct IntroModel {
    public var image: UIImage
    public var mainTitle: String
    public var subTitle: String
    
    public init(image: UIImage, mainTitle: String, subTitle: String) {
        self.image = image
        self.mainTitle = mainTitle
        self.subTitle = subTitle
    }
}
