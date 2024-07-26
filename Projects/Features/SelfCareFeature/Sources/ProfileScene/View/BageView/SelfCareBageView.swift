import UIKit

import SnapKit
import Then

import DSKit

public class SelfCareBageView: UIView {
    private let shadows = UIView()
    private let shapes = UIView()
    private let gradientLayer = CAGradientLayer()
    private var containerView = UIView()
    private let heartImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "heart.fill")
        $0.tintColor = .red
    }

    private var bageNameLabel = MGLabel(
        text: "마음 뱃지",
        font: UIFont.Pretendard.titleMedium,
        textColor: .black,
        isCenter: true
    )
    private var userTimeLabel = MGLabel(
        text: "",
        font: UIFont.Pretendard.bodyMedium,
        textColor: .black,
        isCenter: true
    )
    
    public func setup(
        timeText: Int
    ) {
        self.userTimeLabel.changeText(text: "총 \(timeText)시간 운동하셨어요!")
        self.userTimeLabel.changePointColor(targetString: "\(timeText)", color: DSKitAsset.Colors.blue500.color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {

        setupShadows()
        setupShapes()
        addHeartIcon()
    }

    private func setupShadows() {
        shadows.frame = bounds
        shadows.clipsToBounds = false
        addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 16)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
    }

    private func setupShapes() {
        shapes.frame = bounds
        shapes.clipsToBounds = true
        addSubview(shapes)

        gradientLayer.colors = [
            UIColor.lighterGray.cgColor,
            UIColor.darkerGray.cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(
            a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0)
        )
        gradientLayer.bounds = shapes.bounds.insetBy(
            dx: -0.5 * shapes.bounds.size.width, dy: -0.5 * shapes.bounds.size.height
        )
        gradientLayer.position = shapes.center
        shapes.layer.addSublayer(gradientLayer)
        shapes.layer.cornerRadius = 16
        shapes.layer.borderWidth = 2
        shapes.layer.borderColor = UIColor.lighterGray.cgColor
    }

    private func addHeartIcon() {
        addSubviews([heartImageView,
                     bageNameLabel,
                     userTimeLabel])

        heartImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45.0)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }

        bageNameLabel.snp.makeConstraints {
            $0.top.equalTo(heartImageView.snp.bottom).offset(32.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        userTimeLabel.snp.makeConstraints {
            $0.top.equalTo(bageNameLabel.snp.bottom).offset(6.0)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
}

extension UIColor {
    static var lighterGray: UIColor {
        return UIColor(red: 0.942, green: 0.948, blue: 0.961, alpha: 1)
    }

    static var darkerGray: UIColor {
        return UIColor.white
    }
}
