public class TimerModel {
    public struct Time {
        var time: Int
        var isClicked: Bool
    }

    private var _data: [Time]

    var data: [Time] {
        return _data
    }

    init() {
        _data = [
            Time(time: 60, isClicked: false),
            Time(time: 10, isClicked: false),
            Time(time: 4660, isClicked: false),
            Time(time: 3600, isClicked: false),
            Time(time: 700, isClicked: false),
            Time(time: 5, isClicked: false),
        ]
    }

    func updateData(at index: Int, with newValue: Time) {
        _data[index] = newValue
    }
}
