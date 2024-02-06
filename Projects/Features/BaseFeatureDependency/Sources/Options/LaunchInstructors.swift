//
//  LaunchInstructors.swift
//  BaseFeatureDependency
//
//  Created by 박준하 on 2/6/24.
//  Copyright © 2024 MaeumGaGym-iOS. All rights reserved.
//
import Foundation

enum LaunchInstructor {
    
    case main
    case auth
    case onboarding

    static func configure(isAutorized: Bool = true, tutorialWasShown: Bool = true) -> LaunchInstructor {
        
        let isAutorized = isAutorized
        let tutorialWasShown = tutorialWasShown
        
        switch (tutorialWasShown, isAutorized) {
            case (true, false), (false, false): return .auth
            case (false, true): return .onboarding
            case (true, true): return .main
        }
    }
}
