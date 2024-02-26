import XCTest
import Foundation
import MGLogger

class MGLoggerTests: XCTestCase {

    func test_로깅_출력되는지_결과값_확인() {
        let logsDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(),
                                   isDirectory: true).appendingPathComponent("logs", isDirectory: true)
        let fileURL = logsDirectoryURL.appendingPathComponent("test.log")

        let levels: [Level] = [.verbose, .debug, .warning, .error, .test]
        for level in levels {
            // 로그 파일 초기화
            try? FileManager.default.removeItem(at: fileURL)

            MGLogger.configure(fileName: "test.log", saveFileNum: 1, saveLevel: level, printLevel: level)

            MGLogger.verbose("This is a verbose log.")
            MGLogger.debug("This is a debug log.")
            MGLogger.warning("This is a warning log.")
            MGLogger.error("This is an error log.")
            MGLogger.test("This is a test log.")
        }
    }
}
