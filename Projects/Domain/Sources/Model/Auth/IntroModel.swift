import UIKit

public struct IntroModel {
    var image: UIImage
    var mainTitle: String
    var subTitle: String
    
    public init(image: UIImage, mainTitle: String, subTitle: String) {
        self.image = image
        self.mainTitle = mainTitle
        self.subTitle = subTitle
    }
}
