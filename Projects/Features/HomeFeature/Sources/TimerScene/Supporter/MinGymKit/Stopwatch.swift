import Foundation
import RxSwift

public class Stopwatch: NSObject {
    private var counter: Double = 0.0
    private var timer: Timer?
    private var lapTimes: [Double] = []
    private let timeSubject = PublishSubject<String>()
    private let recordSubject = PublishSubject<[String]>()
    
    public var timeUpdate: Observable<String> {
        return timeSubject.asObservable()
    }
    
    public var recordUpdate: Observable<[String]> {
        return recordSubject.asObservable()
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.035, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.counter += 0.035
            let timeString = self.timeString(from: self.counter)
            self.timeSubject.onNext(timeString)
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        counter = 0
        lapTimes.removeAll()
    }
    
    func record() {
        lapTimes.append(counter)
        let lapTimesString = lapTimes.map { timeString(from: $0) }
        recordSubject.onNext(lapTimesString)
    }
    
    private func timeString(from counter: Double) -> String {
        let minutes: String = String(format: "%02d", Int(counter / 60))
        let seconds: String = String(format: "%02d", Int(counter.truncatingRemainder(dividingBy: 60)))
        let milliseconds: String = String(format: "%02d", Int((counter * 100).truncatingRemainder(dividingBy: 100)))
        return "\(minutes):\(seconds).\(milliseconds)"
    }
}

public class MindGymStopWatchKit {
    
    public let mainStopwatch: Stopwatch = Stopwatch()
    
    public func startTimer() {
        mainStopwatch.start()
    }
    
    public func stopTimer() {
        mainStopwatch.stop()
    }
    
    public func resetTimer() {
        mainStopwatch.reset()
    }
    
    public func recordTime() {
        mainStopwatch.record()
    }
    
}

