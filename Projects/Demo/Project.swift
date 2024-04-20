import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: "\(Environment.workspaceName)-Demo",
    targets: [.app, .unitTest],
    internalDependencies: [
        .data,
        .Modules.mgFlow
    ]
)
