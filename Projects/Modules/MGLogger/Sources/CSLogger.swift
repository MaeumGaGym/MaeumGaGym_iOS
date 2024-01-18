import UIKit

public final class MGLogger {
    
    private static let dateFormatter = DateFormatter()
    private static var dateFormat: String = "yyyy년/MM월/dd일-HH:mm:ss초"
    
    private static var saveFileNum: Int = 10
    private static var filename: String = ""
    
    private static let fileManager = FileManager.default
    private static var logsDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("logs", isDirectory: true)
    
    private static let loggingQueue = DispatchQueue(label: "loggingQueue")
    
    private static var threadName: String {
        if let threadName = Thread.current.name, !threadName.isEmpty {
            return threadName
        }
        else if let queueName = DispatchQueue.currentQueueLabel, !queueName.isEmpty {
            return queueName
        }
        else {
            return "unknown thread"
        }
    }
    
    private static var printLevel: Level = .verbose
    private static var saveLevel: Level = .verbose
    
    private static var time: String {
        let now = Date()
        MGLogger.dateFormatter.dateFormat = MGLogger.dateFormat
        let dateNow = dateFormatter.string(from: now)
        return dateNow
    }
    
    public static func configure(
        fileName: String? = nil,
        saveFileNum: Int? = nil,
        dateFormat: String? = nil,
        logsDirectoryURL: URL? = nil,
        saveLevel: Level = .verbose,
        printLevel: Level = .verbose
    ) {
        self.logsDirectoryURL = logsDirectoryURL ?? self.logsDirectoryURL
        
        if !fileManager.fileExists(atPath: self.logsDirectoryURL.path) {
            try? fileManager.createDirectory(at: self.logsDirectoryURL, withIntermediateDirectories: true)
        }
        
        self.filename = "\(time).log"
        
        self.saveFileNum = saveFileNum ?? self.saveFileNum
        
        self.dateFormat = dateFormat ?? self.dateFormat
        
        guard let fileNames = try? fileManager.contentsOfDirectory(atPath: self.logsDirectoryURL.path) else {
            return
        }
        
        if fileNames.count >= self.saveFileNum { removeFile(fileNames: fileNames) }
        
        self.printLevel = printLevel
        self.saveLevel = saveLevel
    }
    
    
    /// 📢 [VERBOSE]
    public static func verbose(_ items: Any = "", file: String = #file, function: String = #function, line: Int = #line) {
        let tempThreadName = threadName
        loggingQueue.sync {
            printLog(items, level: Level.verbose, file: file, function: function, line: line, threadName: tempThreadName)
            saveLog(items, level: Level.verbose, file: file, function: function, line: line, threadName: tempThreadName)
        }
    }
    
    /// 🛠 [DEBUG]
    public static func debug(_ items: Any = "", file: String = #file, function: String = #function, line: Int = #line) {
        let tempThreadName = threadName
        loggingQueue.sync {
            printLog(items, level: Level.debug, file: file, function: function, line: line, threadName: tempThreadName)
            saveLog(items, level: Level.debug, file: file, function: function, line: line, threadName: tempThreadName)
        }
    }
    
    /// ⚠️ [WARNING]
    public static func warning(_ items: Any = "", file: String = #file, function: String = #function, line: Int = #line) {
        let tempThreadName = threadName
        loggingQueue.sync {
            printLog(items, level: Level.warning, file: file, function: function, line: line, threadName: tempThreadName)
            saveLog(items, level: Level.warning, file: file, function: function, line: line, threadName: tempThreadName)
        }
    }
    
    
    /// 🔥 [ERROR]
    public static func error(_ items: Any = "", file: String = #file, function: String = #function, line: Int = #line) {
        let tempThreadName = threadName
        loggingQueue.sync {
            printLog(items, level: Level.warning, file: file, function: function, line: line, threadName: tempThreadName)
            saveLog(items, level: Level.warning, file: file, function: function, line: line, threadName: tempThreadName)
        }
    }
    
    /// 🎮 [TEST]
    public static func test(_ items: Any = "", file: String = #file, function: String = #function, line: Int = #line) {
        let tempThreadName = threadName
        loggingQueue.sync {
            printLog(items, level: Level.test, file: file, function: function, line: line, threadName: tempThreadName)
            saveLog(items, level: Level.test, file: file, function: function, line: line, threadName: tempThreadName)
        }
    }
}


extension MGLogger {
    
    private static func saveLog(_ items: Any, level: Level, file: String, function: String, line: Int, threadName: String) {
        
        if !isSavable(level: level) { return }
        
        if !fileManager.fileExists(atPath: logsDirectoryURL.path) {
            try? fileManager.createDirectory(at: logsDirectoryURL, withIntermediateDirectories: true)
        }
        
        var stringToWrite = ""
        if let items = items as? [Any] {
            stringToWrite = getInfos(items, level: level, file: file, function: function, line: line, threadName: threadName)
        } else {
            stringToWrite = getInfo(items, level: level, file: file, function: function, line: line, threadName: threadName)
        }

        save(saveString: stringToWrite)
    }
    
    private static func save(saveString: String) {
        let fileURL = logsDirectoryURL.appendingPathComponent(filename)
        var newString = saveString
        if let existedString = get(fileUrl: fileURL) {
            newString = existedString + saveString
        }
        try? newString.write(to: fileURL, atomically: true, encoding: .utf8)
    }
    
    public static func get(fileUrl: URL) -> String? {
        if !fileManager.fileExists(atPath: fileUrl.path) {
            
            let defaultInfo = getHeaderInfo()
            try? defaultInfo.write(to: fileUrl, atomically: true, encoding: .utf8)
            return defaultInfo
        }
        
        let contents = try? String(contentsOf: fileUrl)
        return contents
    }
        
    private static func printLog(_ items: Any, level: Level, file: String, function: String, line: Int, threadName: String) {
        #if DEBUG
        
        if !isprintable(level: level) { return }
        
        if isArray(items) {
            guard let items = items as? [Any] else { return }
            let info = getInfos(items, level: level, file: file, function: function, line: line, threadName: threadName)
            print(info)
        } else {
            let info = getInfo(items, level: level, file: file, function: function, line: line, threadName: threadName)
            print(info)
        }
        #endif
    }
    
    private static func getInfo(_ items: Any, level: Level, file: String, function: String, line: Int, threadName: String) -> String {
        var ret = ""
        ret += "\(time) "
        ret += level.rawValue
        ret += " [\(threadName)]"
        ret += " \(file.components(separatedBy: "/").last ?? "Some File"):\(line) "
        ret += "\(function)"
        ret += "> \(items)\n"
        return ret
    }
    
    private static func getInfos(_ array: [Any], level: Level, file: String, function: String, line: Int, threadName: String) -> String {
        var ret = ""
        ret += "\(time) "
        ret += level.rawValue
        ret += " [\(threadName)]"
        ret += " \(file.components(separatedBy: "/").last ?? "Some File"):\(line) "
        ret += "\(function)"
        ret += ">"
        array.forEach { ret += " \($0)" }
        return ret
    }
    
    private static func compareFirstEightCharacters(str1: String, str2: String) throws -> Bool {
        guard let firstSix1 = str1.components(separatedBy: "-").first else { return false }
        guard let firstSix2 = str2.components(separatedBy: "-").first else { return true}
        return firstSix1 < firstSix2
    }
    
    private static func removeFile(fileNames: [String]) {
        guard let sorted = try? fileNames.sorted(by: compareFirstEightCharacters),
              let deleted = sorted.first
        else { return }

        let fileUrl = logsDirectoryURL.appendingPathComponent(deleted)
        
        try? fileManager.removeItem(at: fileUrl)
    }
    
    private static func getHeaderInfo() -> String {
        let deviceUUID = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
        let os = UIDevice.current.systemVersion
        let versionNum = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        let buildNum = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "unknown"
        var ret = ""
        ret += "Device Model : \(deviceUUID)"
        ret += "Device OS : \(os)"
        ret += "App Version : \(versionNum)"
        ret += "App Build Number: \(buildNum)\n"
        return ret
    }
    
    private static func isSavable(level: Level) -> Bool {
        return compareLevel(self.saveLevel, with: level)
    }
    
    private static func isprintable(level: Level) -> Bool {
        return compareLevel(self.printLevel, with: level)
    }
    
    private static func compareLevel(_ first:  Level, with second: Level) -> Bool {
        switch (first, second) {
        case (.verbose, _):
            return true
        case (.debug, .verbose):
            return false
        case (.debug, _):
            return true
        case (.warning, .verbose):
            return false
        case (.warning, .debug):
            return false
        case (.warning, _):
            return true
        case (.error, .error):
            return true
        case (.error, _):
            return false
        case (.test, _):
            return false
        }

    }
    
}

extension MGLogger {
    private static func isArray<T>(_ value: T) -> Bool {
        let mirror = Mirror(reflecting: value)
        return mirror.displayStyle == .collection
    }

}

fileprivate extension DispatchQueue {
    static var currentQueueLabel: String? {
        return String(validatingUTF8: __dispatch_queue_get_label(nil))
    }
}
