//
//  Settings.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2/16/24.
//

import ProjectDescription

public extension SettingsDictionary{
    static let codeSign = SettingsDictionary()
        .codeSignIdentityAppleDevelopment()
        .automaticCodeSigning(devTeam: "92YDTRVDUA")
}
