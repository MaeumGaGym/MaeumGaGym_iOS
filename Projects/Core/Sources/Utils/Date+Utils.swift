import Foundation

public enum DateFormatIndicated: String {
    ///M월 d일 (E)
    case dateAndDays = "M월 d일 (E)"
    ///yyyy-MM-dd
    case fullDate = "yyyy-MM-dd"
    ///yyyy년 MM월
    case yearsAndMonthKor = "yyyy년 MM월"
    ///yyyy
    case year = "yyyy"
    ///MMMM
    case fullMonth = "MMMM"
    ///M월
    case month = "M월"
    ///d
    case day = "d"
    ///MM월 dd일
    case monthAndDay = "MM월 dd일"
    ///yyyy년 MM월 dd일 (E)
    case fullDateKor = "yyyy년 MM월 dd일 (E)"
    ///yyyy년 MM월 dd일
    case fullDateKorForCalendar = "yyyy년 MM월 dd일"
    ///요일
    case dayKor = "E요일"
}

public extension Date {
    func toString(type: DateFormatIndicated) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return dateFormatter.string(from: self)
    }

        var onlyDate: Date? {
            get {
                let calender = Calendar.current
                var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
                dateComponents.timeZone = NSTimeZone.system
                return calender.date(from: dateComponents)
            }
        }
    
}

public extension String {
    func changeDateFormatWithInput(input: DateFormatIndicated, type: DateFormatIndicated) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")

        dateFormatter.dateFormat = input.rawValue

        guard let date = dateFormatter.date(from: self) else {
            print("잘못된 날짜 형식입니다.")
            return nil
        }

        dateFormatter.dateFormat = type.rawValue

        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }
    
    func toDate(type: DateFormatIndicated) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
