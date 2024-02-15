import Foundation

public class TimerModel {
    public struct Time {
        var time: Double
        var isClicked: Bool
    }
    private var privateData: [Time]
    
    var data: [Time] {
        return privateData
    }
    
    init() {
        privateData = [
            Time(time: 60.0, isClicked: true),
            Time(time: 10.0, isClicked: false),
            Time(time: 4660.0, isClicked: false),
            Time(time: 3600.0, isClicked: false),
            Time(time: 700.0, isClicked: false),
            Time(time: 5.0, isClicked: false),
        ]
    }
    
    func updateData(at index: Int, with newValue: Time) {
        privateData[index] = newValue
    }
    
    public func getTime(at index: Int) -> Double {
        return privateData[index].time
    }
}
