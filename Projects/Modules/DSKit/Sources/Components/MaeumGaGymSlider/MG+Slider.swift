import UIKit

public class MGSlider: UISlider {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        settings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settings() {
        self.value = 180.0
        self.minimumValue = 0
        self.maximumValue = 300
        self.thumbTintColor = DSKitAsset.Colors.blue400.color
        self.minimumTrackTintColor = DSKitAsset.Colors.blue400.color

        let thumbImage = generateThumbImage(diameter: 16)
        self.setThumbImage(thumbImage, for: .normal)
    }
    
    private func generateThumbImage(diameter: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(DSKitAsset.Colors.blue400.color.cgColor)
        context?.addArc(center: CGPoint(x: diameter / 2, y: diameter / 2),
                        radius: diameter / 2, startAngle: 0, endAngle: CGFloat.pi * 2,
                        clockwise: true)
        context?.drawPath(using: .fill)

        let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return thumbImage!
    }
}
