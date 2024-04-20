import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: Environment.workspaceName,
    targets: [.app, .unitTest, .uiTest],
    packages: [
//        .googleSignIn
    ],
    internalDependencies: [
        .data,
        .Modules.mgFlow,
//        .SPM.GoogleSignIn
    ]
)
