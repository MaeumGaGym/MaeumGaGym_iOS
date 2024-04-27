import Foundation

public enum Level: String {
    // 상세한 정보를 로깅하는 레벨입니다.
    case verbose = "📢 [VERBOSE]"
    
    // 디버그용 정보를 로깅하는 레벨입니다. 앱의 내부 동작을 추적할 때 사용합니다.
    case debug = "🛠 [DEBUG]"

    // 경고를 로깅하는 레벨입니다. 앱의 동작에 영향을 줄 수 있는 주의 사항을 기록하는데 사용합니다.
    case warning = "⚠️ [WARNING]"
    
    // 에러를 로깅하는 레벨입니다. 앱에서 발생한 오류를 기록하는 데 사용합니다.
    case error = "🔥 [ERROR]"
    
    // 테스트를 로깅해보는 레벨입니다. 앱의 테스트를 하기 위해서 사용합니다.
    case test = "🎮 [TEST]"
}
