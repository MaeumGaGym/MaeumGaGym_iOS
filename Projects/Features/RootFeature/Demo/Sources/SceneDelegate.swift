import UIKit
import HealthKit
import RootFeature
import RxFlow
import Core
import Foundation

import MGFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        let stepper = AppStepper()
        let initFlow = InitFlow()
        let healthStore = HKHealthStore()

        coordinator.coordinate(flow: initFlow, with: stepper)
        Flows.use(initFlow, when: .created) { root in
            self.window?.backgroundColor = UIColor.white
            self.window?.rootViewController = root
            self.window?.makeKey()
        }

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
