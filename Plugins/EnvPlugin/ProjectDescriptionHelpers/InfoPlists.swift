import ProjectDescription

public extension Project {
    static let appInfoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.maeumGaGym-stamp-iOS.release",
        "CFBundleDisplayName": "Maeumgajim",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "UIAppFonts": [
                "Item 0": "Pretendard-Black.otf",
                "Item 1": "Pretendard-Bold.otf",
                "Item 2": "Pretendard-ExtraBold.otf",
                "Item 3": "Pretendard-ExtraLight.otf",
                "Item 4": "Pretendard-Light.otf",
                "Item 5": "Pretendard-Medium.otf",
                "Item 6": "Pretendard-Regular.otf",
                "Item 7": "Pretendard-SemiBold.otf",
                "Item 8": "Pretendard-Thin.otf"
        ],
        "App Transport Security Settings": ["Allow Arbitrary Loads": true],
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "ITSAppUsesNonExemptEncryption": false,
        "NSPhotoLibraryAddUsageDescription": "사진을 저장할 수 있도록 해주세요",
        "NSCameraUsageDescription": "카메라 접근을 허용할 수 있도록 해주세요",
        "CFBundleURLTypes": [
            [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLName": "maeumGaGym-makers",
                "CFBundleURLSchemes": ["maeumGaGym-makers"]
            ]
        ],
        "UIBackgroundModes": ["remote-notification"]
    ]
    
    static let demoInfoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0.0",
      "CFBundleDevelopmentRegion": "ko",
      "CFBundleVersion": "1",
      "CFBundleIdentifier": "com.maeumGaGym-stamp-iOS.test",
      "CFBundleDisplayName": "maeumGaGym-Test",
      "UILaunchStoryboardName": "LaunchScreen",
      "UIApplicationSceneManifest": [
          "UIApplicationSupportsMultipleScenes": false,
          "UISceneConfigurations": [
              "UIWindowSceneSessionRoleApplication": [
                  [
                      "UISceneConfigurationName": "Default Configuration",
                      "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                  ],
              ]
          ]
      ],
      "UIAppFonts": [
        "Item 0": "Pretendard-Black.otf",
        "Item 1": "Pretendard-Bold.otf",
        "Item 2": "Pretendard-ExtraBold.otf",
        "Item 3": "Pretendard-ExtraLight.otf",
        "Item 4": "Pretendard-Light.otf",
        "Item 5": "Pretendard-Medium.otf",
        "Item 6": "Pretendard-Regular.otf",
        "Item 7": "Pretendard-SemiBold.otf",
        "Item 8": "Pretendard-Thin.otf"
      ],
      "App Transport Security Settings": ["Allow Arbitrary Loads": true],
      "NSPhotoLibraryAddUsageDescription": "사진을 저장할 수 있도록 해주세요",
      "NSCameraUsageDescription": "카메라 접근을 허용할 수 있도록 해주세요",
      "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
      "ITSAppUsesNonExemptEncryption": false,
//      "UIUserInterfaceStyle": "Dark",
      "CFBundleURLTypes": [
          [
              "CFBundleTypeRole": "Editor",
              "CFBundleURLName": "maeumGaGym-makers",
              "CFBundleURLSchemes": ["maeumGaGym-makers"]
          ]
      ],
      "UIBackgroundModes": ["remote-notification"]
  ]
}
