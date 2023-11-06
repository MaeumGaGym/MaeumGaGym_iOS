import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: Environment.workspaceName,
    targets: [.app, .unitTest, .uiTest],
    internalDependencies: [
        .data,
        .Features.RootFeature
    ]
)
