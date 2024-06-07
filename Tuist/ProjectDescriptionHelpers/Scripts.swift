//import ProjectDescription
//
//public extension TargetScript {
//    static let swiftLintScript = TargetScript.pre(
//        script: """
//                if test -d "/opt/homebrew/bin/"; then
//                    PATH="/opt/homebrew/bin/:${PATH}"
//                fi
//
//                export PATH
//
//                if which swiftlint > /dev/null; then
//                    swiftlint lint && swiftlint
//                else
//                    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
//                fi
//                """,
//        name: "SwiftLint",
//        basedOnDependencyAnalysis: false
//    )
//}
