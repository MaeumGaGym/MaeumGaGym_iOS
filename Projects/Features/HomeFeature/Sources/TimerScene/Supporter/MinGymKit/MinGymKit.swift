import UIKit
import RxSwift

public protocol TimerControl {
    var timeUpdate: Observable<String> { get }
    func start()
    func stop()
    func reset()
    func presentTime() -> Double
}

open class MindGymTimerKit {
    public let mainTimer: TimerControl = MindGaGymKitTimer()

    public func setting(count: Double) {
        (mainTimer as? MindGaGymKitTimer)?.setting(count: count)
    }

    public func startTimer() {
        mainTimer.start()
    }

    public func stopTimer() {
        mainTimer.stop()
    }

    public func resetTimer() {
        mainTimer.reset()
    }

    public func restartTimer() {
        (mainTimer as? MindGaGymKitTimer)?.restart()
    }
    
    public func presentTimer() -> Double {
        let presentTime: Double = mainTimer.presentTime()
        return presentTime
    }
}
