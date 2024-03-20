import ProjectDescription

public enum Environment {
    public static let workspaceName = "MaeumGaGym-iOS"
}

public extension Project {
    enum Environment {
        public static let workspaceName = "MaeumGaGym-iOS"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "11.0", devices: .iphone)
        public static let platform = Platform.iOS
        public static let bundlePrefix = "com.maeumGaGym-health-iOS"
        public static let baseSetting: SettingsDictionary = SettingsDictionary()
    }
}
