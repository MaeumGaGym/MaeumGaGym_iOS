import UIKit

public class MaeumGaGymProgressBarView: UIView {
    
    private var timer = MindGymTimerKit()
    private var radius: Double!
    private var colorCircle: UIColor!
    private var trackLayer: CAShapeLayer!
    private var circleShapeLayer: CAShapeLayer!
    
    private var durationTimer = 1
    
    public init(
        center: CGPoint,
        radius: Double,
        color: UIColor
    ) {
        super.init(frame: CGRect(origin: CGPoint(x: center.x - CGFloat(radius), y: center.y - CGFloat(radius)), size: CGSize(width: radius * 2, height: radius * 2)))
        self.colorCircle = color
        self.radius = radius
        self.backgroundColor = .clear
        
        self.trackLayer = configureTrackLayer()
        self.layer.addSublayer(trackLayer)
        
        self.circleShapeLayer = configureCircleLayer()
        self.layer.addSublayer(circleShapeLayer)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startTimer(for seconds: Int) {
        durationTimer = seconds
        timer.setting(count: Double(durationTimer))
        
        circleShapeLayer.add(createCircleAnimation(), forKey: "key")
        timer.startTimer()
    }
    
    @objc private func timerAction() {
        if durationTimer > 0 {
            durationTimer -= 1
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.stopTimer()
        circleShapeLayer.strokeEnd = 0
    }
    
    private func configureCircleLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.path = circlePath()
        progressLayer.strokeColor = colorCircle.cgColor
        progressLayer.lineWidth = 6
        progressLayer.lineCap = .round
        progressLayer.fillColor = UIColor.clear.cgColor
        return progressLayer
    }
    
    private func configureTrackLayer() -> CAShapeLayer {
        let trackLayer = CAShapeLayer()
        trackLayer.path = circlePath()
        trackLayer.strokeColor = DSKitAsset.Colors.gray100.color.cgColor
        trackLayer.lineWidth = 4
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        return trackLayer
    }
    
    private func circlePath() -> CGPath {
        UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                     radius: CGFloat(radius),
                     startAngle: -CGFloat.pi / 2,
                     endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
                     clockwise: true).cgPath
    }
    
    private func createCircleAnimation() -> CABasicAnimation {
        
        let strokeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        
        strokeAnimation.toValue = 0
        strokeAnimation.fromValue = 1
        strokeAnimation.duration = CFTimeInterval(durationTimer)
        strokeAnimation.isRemovedOnCompletion = true
        circleShapeLayer.strokeEnd = 0
        return strokeAnimation
    }
}
