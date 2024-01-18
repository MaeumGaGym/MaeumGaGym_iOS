import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Data",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
        .domain,
        .Modules.mgNetworks
    ]
)
