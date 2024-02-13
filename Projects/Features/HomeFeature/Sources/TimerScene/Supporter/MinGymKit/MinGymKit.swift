import UIKit
import RxSwift

public protocol TimerControl {
    var timeUpdate: Observable<String> { get }
    func setting(initialTime: Int)
    func start()
    func stop()
    func reset()
    func restart()
    func presentTime() -> Int
}

open class MindGymTimerKit {
    public let mainTimer: TimerControl = MindGaGymKitTimer()

    public func setting(time: Int) {
        mainTimer.setting(initialTime: time)
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
        mainTimer.restart()
    }
    
    public func presentTimer() -> Int {
        return mainTimer.presentTime()
    }
}
