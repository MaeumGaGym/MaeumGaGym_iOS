import ProjectDescription

public extension Project {
    static let appInfoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "0.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.maeumGaGym-health-iOS.release",
        "CFBundleDisplayName": "마음가짐",
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
        "NSPhotoLibraryUsageDescription": "애플리케이션이 앨범에 접근하여 사진을 불러오기 위해 필요합니다.",
        "NSHealthShareUsageDescription": "건강 관련 데이터를 읽어오기 위해 필요합니다.",
        "NSHealthUpdateUsageDescription": "건강 관련 데이터를 업데이트하기 위해 필요합니다.",
        "CFBundleURLTypes": [
            [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLName": "kakao44df4ecfe4e1218c17550a6ab201d87d",
                "CFBundleURLSchemes": ["kakao44df4ecfe4e1218c17550a6ab201d87d"]
            ]
        ],
        "UIBackgroundModes": ["remote-notification"],
        
        "LSApplicationQueriesSchemes": [
            "kakaokompassauth",
            "kakaolink",
            "kakaoplus"
        ],
        
        "GoogleService-Info": .dictionary([
            "CLIENT_ID": .string("9435200486-2epc0q27qhose5v9gkjr5vfa7o97md9u.apps.googleusercontent.com"),
            "REVERSED_CLIENT_ID": .string("com.googleusercontent.apps.9435200486-2epc0q27qhose5v9gkjr5vfa7o97md9u"),
            "PLIST_VERSION": .string("1"),
            "BUNDLE_ID": .string("com.maeumGaGym-health-iOS.release"),
        ]),
    ]
    
    static let demoInfoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "0.0.0",
      "CFBundleDevelopmentRegion": "ko",
      "CFBundleVersion": "1",
      "CFBundleIdentifier": "com.maeumGaGym-health-iOS.test",
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
      "NSPhotoLibraryUsageDescription": "애플리케이션이 앨범에 접근하여 사진을 불러오기 위해 필요합니다.",
      "NSHealthShareUsageDescription": "건강 관련 데이터를 읽어오기 위해 필요합니다.",
      "NSHealthUpdateUsageDescription": "건강 관련 데이터를 업데이트하기 위해 필요합니다.",
      "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
      "ITSAppUsesNonExemptEncryption": false,
//      "UIUserInterfaceStyle": "Dark",
      "CFBundleURLTypes": [
          [
              "CFBundleTypeRole": "Editor",
              "CFBundleURLName": "kakao44df4ecfe4e1218c17550a6ab201d87d",
              "CFBundleURLSchemes": ["kakao44df4ecfe4e1218c17550a6ab201d87d"]
          ]
      ],
      
      "UIBackgroundModes": ["remote-notification"],
      
      "LSApplicationQueriesSchemes": [
          "kakaokompassauth",
          "kakaolink",
          "kakaoplus"
      ],
  ]
}
