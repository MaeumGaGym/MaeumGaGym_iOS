import ProjectDescription

public enum Environment {
    public static let workspaceName = "Maeumgajim-iOS"
}

public extension Project {
    enum Environment {
        public static let workspaceName = "Maeumgajim-iOS"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
        public static let platform = Platform.iOS
        public static let bundlePrefix = "com.maeumgajim-stamp-iOS"
    }
}
