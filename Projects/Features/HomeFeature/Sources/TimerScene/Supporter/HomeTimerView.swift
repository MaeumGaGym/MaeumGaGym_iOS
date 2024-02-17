import UIKit

import RxSwift

import SnapKit
import Then

import DSKit

public class HomeTimerView: UIView {
    
    public var homeTimer = MindGymTimerKit()
    
    private var radius: Double!
    private var colorCircle: UIColor!
    private var trackLayer: CAShapeLayer!
    private var circleShapeLayer: CAShapeLayer!
    
    private var initTime: Double = 0.0
    private var cancelTime: Double = 0.0
    private var currentTime: Double = 0.0
    
    private var timerIndex: Int = 0
    
    var disposeBag = DisposeBag()
    
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
    
    private let alarmImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.homeTimerBell.image
    }
    
    private var timerAlarmTitle = UILabel().then {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.Pretendard.bodyMedium
        $0.textColor = DSKitAsset.Colors.gray400.color
    }
    
    public init(
        center: CGPoint,
        radius: Double,
        color: UIColor
    ) {
        super.init(frame: CGRect(
            origin: CGPoint(x: center.x - CGFloat(radius), y: center.y - CGFloat(radius)),
            size: CGSize(width: radius * 2, height: radius * 2))
        )
        
        self.colorCircle = color
        self.radius = radius
        self.backgroundColor = .clear
        
        self.trackLayer = setTrackLayer()
        self.layer.addSublayer(trackLayer)
        
        self.circleShapeLayer = setCircleLayer()
        self.layer.addSublayer(circleShapeLayer)
        
        layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubviews([timerInitTitle, timerMainTitle, alarmImage, timerAlarmTitle])
        
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
    
    let timerModel = TimerModel()
    
    public func timerChange(for index: Int) {
        initTime = timerModel.getTime(at: index)
        cancelTime = initTime
        timerIndex = index
        homeTimer.setTimer(index: index, settingTime: homeTimer.presentTime(index: index))
            
    }
    
    public func timerSetting(for index: Int) {
        initTime = timerModel.getTime(at: index)
        cancelTime = initTime
        timerIndex = index
        homeTimer.setTimer(index: index, settingTime: homeTimer.presentTime(index: index))
        setInitialTimeLabel()
        setTimerTimeLabel()
        setInitAlarmTimeLabel()
    }
    
    private func setInitialTimeLabel() {
        if cancelTime == 0 {
            timerInitTitle.text = "0분"
            return
        }
        var time: [Int] = [0, 0, 0]
        let initTimeInt = Int(initTime)
        time[0] = initTimeInt / 3600
        time[1] = (initTimeInt % 3600) / 60
        time[2] = initTimeInt % 60
        
        if time[0] > 0 && time[1] > 0 && time[2] > 0 {
            timerInitTitle.text = "\(time[0])시간 \(time[1])분 \(time[2])초"
        } else if time[0] > 0 && time[2] > 0 {
            timerInitTitle.text = "\(time[0])시간 \(time[2])초"
        } else if time[0] > 0 && time[1] > 0 {
            timerInitTitle.text = "\(time[0])시간 \(time[1])분"
        } else if time[0] > 0 {
            timerInitTitle.text = "\(time[0])시간"
        } else if time[1] > 0  && time[2] > 0{
            timerInitTitle.text = "\(time[1])분  \(time[2])초"
        } else if time[1] > 0 {
            timerInitTitle.text = "\(time[1])분"
        } else {
            timerInitTitle.text = "\(time[2])초"
        }
    }
    
    private func setTimerTimeLabel() {
        if cancelTime == 0 {
            timerMainTitle.text = "00 : 00"
            return
        }
        
        timerMainTitle.text = setTimerTimeLabelText(from: homeTimer.presentTime(index: timerIndex))

        // 이전 구독을 해제합니다.
        disposeBag = DisposeBag()

        let currentTimer = homeTimer.timers[timerIndex]
        currentTimer.timeUpdate
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [self] timeString in
                DispatchQueue.main.async { [self] in
                    currentTime = homeTimer.presentTime(index: timerIndex)
                    timerMainTitle.text = timeString
                }
            })
            .disposed(by: disposeBag)
    }

    
    
    private func setTimerTimeLabelText(from counter: Double) -> String {
        let totalSeconds = Int(counter)
        let hours: String = String(format: "%02d", totalSeconds / 3600)
        let minutes: String = String(format: "%02d", (totalSeconds % 3600) / 60)
        let seconds: String = String(format: "%02d", totalSeconds % 60)

        if totalSeconds / 3600 >= 1 {
            return "\(hours) : \(minutes) : \(seconds)"
        } else if totalSeconds / 60 >= 1 {
            return "\(minutes) : \(seconds)"
        } else {
            return "00 : \(seconds)"
        }
    }
    
    private func setInitAlarmTimeLabel() {
        if cancelTime == 0 {
            timerAlarmTitle.text = ""
            return
        }
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "a h:mm"
        formatterTime.amSymbol = "오전"
        formatterTime.pmSymbol = "오후"
        let currentTimeString = formatterTime.string(from: Date().addingTimeInterval(initTime))
        DispatchQueue.main.async {
            self.timerAlarmTitle.text = currentTimeString
        }
    }

    private func setAlarmTimeLabel() {
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "a h:mm"
        formatterTime.amSymbol = "오전"
        formatterTime.pmSymbol = "오후"
        let currentTimeString = formatterTime.string(from: Date().addingTimeInterval(currentTime))
        DispatchQueue.main.async {
            self.timerAlarmTitle.text = currentTimeString
        }
    }
    
    public func startTimer() -> Bool {
        if currentTime == 0.0 {
            return false
        } else {
            if circleShapeLayer.speed == 0 {
                restartCricleAnimation()
                homeTimer.startTimer(index: timerIndex)
                setAlarmTimeLabel()
            } else {
                circleShapeLayer.add(createCircleAnimation(), forKey: "key")
                homeTimer.startTimer(index: timerIndex)
                setAlarmTimeLabel()
            }
            circleShapeLayer.strokeColor = colorCircle.cgColor
        }
        return true
    }

    public func stopTimer() {
        circleShapeLayer.strokeColor = DSKitAsset.Colors.gray400.color.cgColor
        stopCricleAnimation()
        homeTimer.stopTimer(index: timerIndex)
    }
    
    public func cancelTimer() {
        cancelTime = 0.0
        homeTimer.setTimer(index: timerIndex, settingTime: 0.0)
        circleShapeLayer.add(createCircleAnimation(), forKey: "key")
        stopCricleAnimation()
        homeTimer.stopTimer(index: timerIndex)
        stopTimer()
        setInitAlarmTimeLabel()
        setInitialTimeLabel()
    }
    
    public func restartTimer() {
        homeTimer.setTimer(index: timerIndex, settingTime: initTime)
        cancelTime = initTime
        circleShapeLayer.add(createCircleAnimation(), forKey: "key")
        stopCricleAnimation()
        homeTimer.stopTimer(index: timerIndex)
        setAlarmTimeLabel()
        setInitialTimeLabel()
    }
    
    public func currentTimer(index: Int) -> Double {
        return homeTimer.presentTime(index: index)
    }

    private func setCircleLayer() -> CAShapeLayer {
        let circleLayer = CAShapeLayer().then {
            $0.path = setCirclePath()
            $0.strokeColor = colorCircle.cgColor
            $0.lineWidth = 6
            $0.lineCap = .round
            $0.fillColor = UIColor.clear.cgColor
        }
        return circleLayer
    }
    
    private func setTrackLayer() -> CAShapeLayer {
        let trackLayer = CAShapeLayer().then {
            $0.path = setCirclePath()
            $0.strokeColor = DSKitAsset.Colors.gray100.color.cgColor
            $0.lineWidth = 4
            $0.lineCap = .round
            $0.fillColor = UIColor.clear.cgColor
        }
        return trackLayer
    }
    
    private func stopCricleAnimation() {
        let pausedTime = circleShapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        circleShapeLayer.speed = 0
        circleShapeLayer.timeOffset = pausedTime
    }
    
    private func restartCricleAnimation() {
        let pausedTime = circleShapeLayer.timeOffset
        circleShapeLayer.speed = 1.0
        circleShapeLayer.timeOffset = 0.0
        circleShapeLayer.beginTime = 0.0
        let timeSincePause = circleShapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleShapeLayer.beginTime = timeSincePause
    }
    
    private func setCirclePath() -> CGPath {
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
        strokeAnimation.duration = CFTimeInterval(homeTimer.presentTime(index: timerIndex))
        strokeAnimation.isRemovedOnCompletion = true
        circleShapeLayer.strokeEnd = 0
        return strokeAnimation
    }
}
