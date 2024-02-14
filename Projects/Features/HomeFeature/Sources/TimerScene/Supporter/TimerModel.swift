public class TimerModel {
    public struct Time {
        var time: Int
        var isClicked: Bool
    }

    private var data: [Time]

    var data: [Time] {
        return data
    }

    init() {
        data = [
            Time(time: 60, isClicked: false),
            Time(time: 10, isClicked: false),
            Time(time: 4660, isClicked: false),
            Time(time: 3600, isClicked: false),
            Time(time: 700, isClicked: false),
            Time(time: 5, isClicked: false),
        ]
    }

    func updateData(at index: Int, with newValue: Time) {
        data[index] = newValue
    }
    
    public func getTime(at index: Int) -> Int {
        return data[index].time
    }
}
