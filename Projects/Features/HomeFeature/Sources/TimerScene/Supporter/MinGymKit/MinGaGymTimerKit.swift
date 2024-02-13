import UIKit

import RxSwift

open class MindGaGymKitTimer: NSObject, TimerControl {
    
    private var initTime: Int = 0
    private var time: Double = 0
    private var timer: Timer?
    
    private let timerSubject = PublishSubject<String>()
    public var timeUpdate: Observable<String> {
        return timerSubject.asObservable()
    }

    public func setting(initialTime: Int) {
        initTime = initialTime
        time = Double(initialTime)
        setTimerString()
    }

    public func start() {
       reduceTime()
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    public func restart() {
        time = Double(initTime)
        setTimerString()
    }
    
    public func reset() {
        time = 0
        initTime = 0
        setTimerString()
    }
    
    public func setTimerString() {
        let timeString = timerString(count: Int(time))
        timerSubject.onNext(timeString)
    }
    
    public func presentTime() -> Int {
        return time
    }
    
    private func reduceTime() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [self] _ in
            if time <= 0 {
                stop()
            } else {
                time -= 0.001
                setTimerString()
            }
        }
    }
    
    private func timerString(count: Int) -> String {
        let totalSeconds: Int = count
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
}

