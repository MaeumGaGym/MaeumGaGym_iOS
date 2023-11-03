//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 11/1/23.
//

import ProjectDescription
import EnvPlugin

let workspace = Workspace(
    name: Environment.workspaceName,
    projects: [
        "./**"
    ]
)
