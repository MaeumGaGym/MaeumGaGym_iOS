import UIKit
import RxSwift

open class MindGaGymKitTimer: NSObject, TimerControl {
    
    private var initCounter: Double = 0.0
    private var counter: Double = 0.0
    private var timer: Timer?
    private var lapTimes: [Double] = []
    private let timerSubject = PublishSubject<String>()
    private let recordSubject = PublishSubject<[String]>()

    public var timeUpdate: Observable<String> {
        return timerSubject.asObservable()
    }

    public func setting(count: Double) {
        initCounter = count
        self.counter = count
        let timeString = self.timeString(from: self.counter)
        self.timerSubject.onNext(timeString)
    }

    public func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.035, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.counter -= 0.035
            let timeString = self.timeString(from: self.counter)
            self.timerSubject.onNext(timeString)
        }
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }

    public func restart() {
        counter = initCounter
        let timeString = self.timeString(from: self.counter)
        self.timerSubject.onNext(timeString)
    }

    public func reset() {
        counter = 0.0
        initCounter = 0.0
        let timeString = self.timeString(from: self.counter)
        self.timerSubject.onNext(timeString)
    }

    public func record() {
        lapTimes.append(counter)
        let lapTimesString = lapTimes.map { timeString(from: $0) }
        recordSubject.onNext(lapTimesString)
    }
    
    private func timeString(from counter: Double) -> String {
        let hours: String = String(format: "%02d", Int(counter / 3600))
        let minutes: String = String(format: "%02d", Int(counter / 60))
        let seconds: String = String(format: "%02d", Int(counter.truncatingRemainder(dividingBy: 60)))
        if counter / 3600 >= 1 {
            return "\(hours) : \(minutes) : \(seconds)"
        } else if counter / 60 > 1 {
            return "\(minutes) : \(seconds)"
        } else {
            return "\(minutes) : \(seconds)"
        }
    }
}
