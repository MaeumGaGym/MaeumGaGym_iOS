import ProjectDescription
import EnvPlugin

let workspace = Workspace(
    name: Environment.workspaceName,
    projects: [
        "./**"
    ]
)
