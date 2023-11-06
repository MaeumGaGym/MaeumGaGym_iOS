//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 11/6/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "CSLogger",
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .core
    ]
)
