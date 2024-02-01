import UIKit

public enum TitleTextFieldType {
    case title
    case startDate
    case finishDate
    case detail
    
    var titleText: String {
        switch self {
        case .title:
            return "제목"
        case .startDate:
            return "시작 날짜"
        case .finishDate:
            return "마감 날짜"
        case .detail:
            return "내용"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .title:
            return "제목을 입력해 주세요."
        case .startDate:
            return ""
        case .finishDate:
            return ""
        case .detail:
            return "내용을 입력해 주세요."
        }
    }
}
