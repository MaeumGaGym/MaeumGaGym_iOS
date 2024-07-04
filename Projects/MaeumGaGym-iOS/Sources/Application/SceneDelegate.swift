import UIKit

import RxFlow

import Core
import Domain
import Data

import MGFlow
import MGNetworks
import AuthFeature

import KakaoSDKAuth
import TokenManager
import AuthFeatureInterface

import HealthKit
import RootFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var mainFlow: AuthFlow!
    let healthStore = HKHealthStore()
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        mainFlow = AuthFlow()

        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: MGStep.authSplashIsRequired))
        Flows.use(mainFlow, when: .created) { root in
            self.window?.rootViewController = root
            self.window?.makeKey()
        }
        
        window?.makeKeyAndVisible()

        if HKHealthStore.isHealthDataAvailable() {
            let allTypes = Set([HKObjectType.workoutType(),
                                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])

            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if success {
                    print("\(success) 성공")
                } else {
                    print("\(error) 성공하지 못했습니다")
                }
            }
        }
        window?.makeKeyAndVisible()
    }
}
