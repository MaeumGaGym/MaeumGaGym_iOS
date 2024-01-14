import Foundation
import UIKit

public enum ToggleButtonType {
    case timerHome
    case metronomeHome
    case morning
    case lunch
    case dinner
    case timer
    case metronome
    case image
    case album
    case bareBody
    case marchine
    
    
    var message: String {
        switch self {
        case .image:
            return "사진"
        case .album:
            return "앨범"
        case .timer:
            return "타이머"
        case .metronome:
            return "메트로놈"
        case .timerHome:
            return "타이머"
        case .metronomeHome:
            return "메트로놈"
        case .morning:
            return "아침"
        case .lunch:
            return "아침"
        case .dinner:
            return "저녁"
        case .bareBody:
            return "맨몸"
        case .marchine:
            return "기구"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .image:
            return DSKitAsset.Colors.gray400.color
        case .album:
            return DSKitAsset.Colors.gray400.color
        case .timer:
            return DSKitAsset.Colors.gray400.color
        case .metronome:
            return DSKitAsset.Colors.gray400.color
        case .timerHome:
            return .black
        case .metronomeHome:
            return .black
        case .morning:
            return .black
        case .lunch:
            return .black
        case .dinner:
            return .black
        case .bareBody:
            return DSKitAsset.Colors.gray600.color
        case .marchine:
            return DSKitAsset.Colors.gray600.color
        }
    }
    
    var textFont: UIFont {
        switch self {
        case .image:
            return UIFont.Pretendard.labelLarge
        case .album:
            return UIFont.Pretendard.labelLarge
        case .timer:
            return UIFont.Pretendard.labelLarge
        case .metronome:
            return UIFont.Pretendard.labelLarge
        case .timerHome:
            return UIFont.Pretendard.bodyMedium
        case .metronomeHome:
            return UIFont.Pretendard.bodyMedium
        case .morning:
            return UIFont.Pretendard.bodyMedium
        case .lunch:
            return UIFont.Pretendard.bodyMedium
        case .dinner:
            return UIFont.Pretendard.bodyMedium
        case .bareBody:
            return UIFont.Pretendard.labelMedium
        case .marchine:
            return UIFont.Pretendard.labelMedium
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .image:
            return .clear
        case .album:
            return .clear
        case .timer:
            return .clear
        case .metronome:
            return .clear
        case .timerHome:
            return DSKitAsset.Colors.gray50.color
        case .metronomeHome:
            return DSKitAsset.Colors.gray50.color
        case .morning:
            return DSKitAsset.Colors.gray50.color
        case .lunch:
            return DSKitAsset.Colors.gray50.color
        case .dinner:
            return DSKitAsset.Colors.gray50.color
        case .bareBody:
            return DSKitAsset.Colors.gray50.color
        case .marchine:
            return DSKitAsset.Colors.gray50.color
        }
    }
    
    var checkedTextColor: UIColor {
        switch self {
        case .image:
            return DSKitAsset.Colors.blue500.color
        case .album:
            return DSKitAsset.Colors.blue500.color
        case .timer:
            return .black
        case .metronome:
            return .black
        case .timerHome:
            return .white
        case .metronomeHome:
            return .white
        case .morning:
            return .white
        case .lunch:
            return .white
        case .dinner:
            return .white
        case .bareBody:
            return .white
        case .marchine:
            return .white
        }
    }
    
    var checkedTextFont: UIFont {
        switch self {
        case .image:
            return UIFont.Pretendard.labelLarge
        case .album:
            return UIFont.Pretendard.labelLarge
        case .timer:
            return UIFont.Pretendard.labelLarge
        case .metronome:
            return UIFont.Pretendard.labelLarge
        case .timerHome:
            return UIFont.Pretendard.titleSmall
        case .metronomeHome:
            return UIFont.Pretendard.titleSmall
        case .morning:
            return UIFont.Pretendard.titleSmall
        case .lunch:
            return UIFont.Pretendard.titleSmall
        case .dinner:
            return UIFont.Pretendard.titleSmall
        case .bareBody:
            return UIFont.Pretendard.labelMedium
        case .marchine:
            return UIFont.Pretendard.labelMedium
        }
    }
    
    var checkedBackgroundColor: UIColor {
        switch self {
        case .image:
            return DSKitAsset.Colors.gray50.color
        case .album:
            return DSKitAsset.Colors.gray50.color
        case .timer:
            return DSKitAsset.Colors.gray50.color
        case .metronome:
            return DSKitAsset.Colors.gray50.color
        case .timerHome:
            return DSKitAsset.Colors.blue500.color
        case .metronomeHome:
            return DSKitAsset.Colors.blue500.color
        case .morning:
            return DSKitAsset.Colors.blue500.color
        case .lunch:
            return DSKitAsset.Colors.blue500.color
        case .dinner:
            return DSKitAsset.Colors.blue500.color
        case .bareBody:
            return DSKitAsset.Colors.blue500.color
        case .marchine:
            return DSKitAsset.Colors.blue500.color
        }
    }
}
