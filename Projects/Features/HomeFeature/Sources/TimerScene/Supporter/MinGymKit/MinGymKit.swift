import UIKit
import RxSwift

public protocol TimerControl {
    var timeUpdate: Observable<String> { get }
    func setting(settingTime: Double)
    func start()
    func stop()
    func reset()
    func restart()
    func presentTime() -> Double
}

open class MindGymTimerKit {
    public var timers: [TimerControl] = []
    
    public func setTimer(index: Int, settingTime: Double) {
        timers[index].setting(settingTime: settingTime)
    }

    public func startTimer(index: Int) {
        timers[index].start()
    }

    public func stopTimer(index: Int) {
        timers[index].stop()
    }

    public func resetTimer(index: Int) {
        timers[index].reset()
    }

    public func restartTimer(index: Int) {
        timers[index].restart()
    }
    
    public func addRearTimer(time: Double) {
        let newTimer = MindGaGymKitTimer()
        newTimer.setting(settingTime: time)
        timers.append(newTimer)
    }
    
    public func deleteTimer(index: Int) {
        timers.remove(at: index)
    }

    public func presentTime(index: Int) -> Double {
        return timers[index].presentTime()
    }
}
