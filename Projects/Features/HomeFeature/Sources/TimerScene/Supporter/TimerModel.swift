import UIKit

import DSKit

public struct Time {
    var time: Int
}

public enum TimerModel {
    case eunho

    var data: [Time] {
        switch self {
        case .eunho:
            return [
                Time(time: 60),
                Time(time: 10),
                Time(time: 4660),
                Time(time: 3600),
                Time(time: 700),
                Time(time: 5),
            ]
        }
    }
}

