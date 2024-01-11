import Foundation

public enum ToggleButtonType {
    case image
    case album
    case timer
    case metronome
    
    var message: String {
        switch self {
        case .image:
            return "사진"
        case .album:
            return "앨범"
        case .timer:
            return "타이머"
        case .metronome:
            return "앨범"
        }
    }
}
