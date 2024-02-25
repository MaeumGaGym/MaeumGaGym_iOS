import UIKit

import SnapKit
import Then

import Core

public class MGImageButton: BaseButton {

    public init(
        image: UIImage? = UIImage(),
        backColor: UIColor? = .clear
    ) {
        super.init(frame: .zero)

        self.setImage(image: image ?? UIImage())
        self.setColor(backColor: backColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
