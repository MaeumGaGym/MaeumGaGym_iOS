import UIKit

public struct SelfCareIntroductModel {
    public var image: UIImage
    public var mainText: String
    public var subText: String

    public init(image: UIImage, mainText: String, subText: String) {
        self.image = image
        self.mainText = mainText
        self.subText = subText
    }
}
