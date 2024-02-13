import UIKit

import RxSwift

open class MindGaGymKitTimer: NSObject, TimerControl {
    
    private var initCounter: Double = 0.0
    private var counter: Double = 0.0
    private var timer: Timer?
    private let timerSubject = PublishSubject<String>()
    public var timeUpdate: Observable<String> {
        return timerSubject.asObservable()
    }

    public func setting(count: Double) {
        initCounter = count
        counter = count
        setInitTimeString()
    }

    public func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [self] _ in
            if counter <= 0.001 {
                timerStop()
            } else {
                counter -= 0.001
                setTimeString()
            }
        }
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    public func timerStop() {
        setInitTimeString()
        timer?.invalidate()
        timer = nil
    }

    public func restart() {
        counter = initCounter
        setInitTimeString()
    }

    public func reset() {
        counter = 0.0
        initCounter = 0.0
        setInitTimeString()
    }
    
    public func presentTime() -> Double {
        return self.counter
    }
    
    public func setTimeString() {
        let timeString = timeString(from: counter)
        timerSubject.onNext(timeString)
    }
    
    public func setInitTimeString() {
        let timeString = initTimeString(from: counter)
        timerSubject.onNext(timeString)
    }
    
    private func timeString(from counter: Double) -> String {
        let totalSeconds = Int(counter) + 1
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
    
    private func initTimeString(from counter: Double) -> String {
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
}
