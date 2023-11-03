import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "BaseFeatureDependency",
    targets: [.dynamicFramework],
    internalDependencies: [
        .domain,
        .Modules.dsKit
    ]
)
