import UIKit
import RxSwift

public class MaeumGaGymProgressBarView: UIView {
    
    private var timer = MindGymTimerKit()
    private var radius: Double!
    private var colorCircle: UIColor!
    private var trackLayer: CAShapeLayer!
    private var circleShapeLayer: CAShapeLayer!
    
    private var durationTimer = 0
    private var initTime:Double = 0.0
    
    let disposeBag = DisposeBag()
    
    private var timerInitTitle = UILabel().then {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.Pretendard.bodyLarge
        $0.textColor = .black
    }
    
    private var timerMainTitle = UILabel().then {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.Pretendard.light.pointSize, weight: .light)
        $0.textColor = .black
    }
    
    private var timerAlarmTitle = UILabel().then {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = .black
    }
    
    
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
        
        layout()
        
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubviews([timerInitTitle, timerMainTitle, timerAlarmTitle])
        
        timerInitTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24.0)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(89.0)
        }
        
        timerMainTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64.0)
            $0.width.equalToSuperview()
            $0.top.equalTo(timerInitTitle.snp.bottom).offset(32.0)
        }
        
        timerAlarmTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20.0)
            $0.width.equalToSuperview()
            $0.top.equalTo(timerMainTitle.snp.bottom).offset(32.0)
        }
    }
    
    private func initTitle() {
        if initTime == 0 {
            timerInitTitle.text = "0분"
            return
        }
        var time: [Double] = [0.0, 0.0, 0.0]
        time[0] = Double(Int(initTime / 3600))
        time[1] = Double(Int(initTime / 60))
        time[2] = initTime.truncatingRemainder(dividingBy: 60)
        
        if initTime.truncatingRemainder(dividingBy: 3600) == 0 {
            timerInitTitle.text = "\(Int(time[0]))시간"
        } else if initTime / 3600 > 1  {
            timerInitTitle.text = "\(Int(time[0]))시간  \(Int(time[1]))분"
        } else if initTime.truncatingRemainder(dividingBy: 60) == 0 {
            timerInitTitle.text = "\(Int(time[1]))분"
        } else if initTime / 60 > 1{
            timerInitTitle.text = "\(Int(time[1]))분  \(Int(time[2]))초"
        } else {
            timerInitTitle.text = "\(Int(time[2]))초"
        }
    }
    
    private func mainTitle() {
        if initTime == 0 {
            timerMainTitle.text = "00 : 00"
            return
        }
        timer.mainTimer.timeUpdate
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] timeString in
                DispatchQueue.main.async {
                    self?.timerMainTitle.text = timeString
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func alarmTime() {
        if initTime == 0 {
            timerAlarmTitle.text = ""
            return
        }
        let formatter_time = DateFormatter()
        formatter_time.dateFormat = "a hh:mm"
        formatter_time.amSymbol = "오전"
        formatter_time.pmSymbol = "오후"
        let current_time_string = formatter_time.string(from: Date().addingTimeInterval(initTime))
        DispatchQueue.main.async {
            self.timerAlarmTitle.text = current_time_string
        }
    }
    
    public func setting(for seconds: Int) {
        durationTimer = seconds
        initTime = Double(seconds)
        mainTitle()
        timer.setting(count: Double(seconds))
        initTitle()
        alarmTime()
    }
    
    @objc private func timerAction() {
        if durationTimer > 0 {
            durationTimer -= 1
        } else {
            stopTimer()
        }
    }
    
    public func startTimer() -> Bool { // 재시작 한뒤 시작되면 카운트다운 label 작동이 안됨
        if durationTimer == 0 {
            return false
        }
        else if circleShapeLayer.speed == 0 {
            resumeAnimation()
            timer.setting(count: Double(durationTimer))
            timer.startTimer()
        } else {
            timer.setting(count: Double(durationTimer))
            circleShapeLayer.add(createCircleAnimation(), forKey: "key")
            timer.startTimer()
        }
        
        return true
    }
    
    
    public func stopTimer() {
        pauseAnimation()
        timer.stopTimer()
    }
    
    public func restartTimer() {
        durationTimer = Int(initTime)
        timer.setting(count: Double(initTime))
        circleShapeLayer.add(createCircleAnimation(), forKey: "key")
        pauseAnimation()
        timer.stopTimer()
        stopTimer()
        alarmTime()
    }
    
    public func closeTimer() {
        durationTimer = 0
        initTime = 0.0
        timer.setting(count: Double(0))
        circleShapeLayer.add(createCircleAnimation(), forKey: "key")
        pauseAnimation()
        timer.stopTimer()
        stopTimer()
        initTitle()
        alarmTime()
    }
    
    private func pauseAnimation() {
        let pausedTime = circleShapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        circleShapeLayer.speed = 0
        circleShapeLayer.timeOffset = pausedTime
    }
    
    private func resumeAnimation() {
        let pausedTime = circleShapeLayer.timeOffset
        circleShapeLayer.speed = 1.0
        circleShapeLayer.timeOffset = 0.0
        circleShapeLayer.beginTime = 0.0
        let timeSincePause = circleShapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleShapeLayer.beginTime = timeSincePause
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
