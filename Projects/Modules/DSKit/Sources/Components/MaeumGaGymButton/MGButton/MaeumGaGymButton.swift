import UIKit

import SnapKit
import Then

import Core

public class MGButton: BaseButton {

    public init(
        titleText: String,
        font: UIFont? = UIFont(),
        image: UIImage? = UIImage(),
        backImage: UIImage? = UIImage(),
        textColor: UIColor? = .black,
        backColor: UIColor? = .clear
    ) {
        super.init(frame: .zero)

        self.setTitle(text: titleText)
        self.setImage(image: image ?? UIImage())
        self.setImage(image: image ?? UIImage(), backImage: backImage ?? UIImage())
        self.setColor(textColor: textColor ?? .black, backColor: backColor ?? .clear)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
