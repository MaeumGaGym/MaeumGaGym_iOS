import ProjectDescription

public extension Gym {
    struct Features {
        public struct Auth {}
        public struct Posture {}
        public struct Home {}
        public struct SelfCare {}
        public struct Shop {}
    }
    
    struct Modules {}
}

// MARK: - Root

public extension Gym {
    static let data = Gym.project(target: "Data", path: .data)

    static let domain = Gym.project(target: "Domain", path: .domain)
    
    static let core = Gym.project(target: "Core", path: .core)    
    
}

// MARK: - Modules

public extension Gym.Modules {
    static let dsKit = Gym.project(target: "DSKit", path: .relativeToModules("DSKit"))
    
    static let networks = Gym.project(target: "Networks", path: .relativeToModules("Networks"))
    
    static let thirdPartyLibs = Gym.project(target: "ThirdPartyLibs", path: .relativeToModules("ThirdPartyLibs"))
    
    static let testCore = Gym.project(target: "TestCore", path: .relativeToModules("TestCore"))
    
    static let tokenManager = Gym.project(target: "TokenManager", path: .relativeToModules("TokenManager"))
    
    static let csLogger = Gym.project(target: "CSLogger", path: .relativeToModules("CSLogger"))

}

// MARK: - Features

public extension Gym.Features {
    static func project(name: String, group: String) -> Gym { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }
    
    static let BaseFeatureDependency = TargetDependency.project(target: "BaseFeatureDependency", path: .relativeToFeature("BaseFeatureDependency"))
    
    static let RootFeature = TargetDependency.project(target: "RootFeature", path: .relativeToFeature("RootFeature"))
}

public extension Gym.Features.Auth {
    static let group = "Auth"
    
    static let Feature = Gym.Features.project(name: "Feature", group: group)
    static let Interface = Gym.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Gym.Features.Posture {
    static let group = "Posture"
    
    static let Feature = Gym.Features.project(name: "Feature", group: group)
    static let Interface = Gym.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Gym.Features.Home {
    static let group = "Home"
    
    static let Feature = Gym.Features.project(name: "Feature", group: group)
    static let Interface = Gym.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Gym.Features.SelfCare {
    static let group = "SelfCare"
    
    static let Feature = Gym.Features.project(name: "Feature", group: group)
    static let Interface = Gym.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Gym.Features.Shop {
    static let group = "Shop"
    
    static let Feature = Gym.Features.project(name: "Feature", group: group)
    static let Interface = Gym.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}
