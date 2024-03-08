import UIKit
import HomeFeature
import RxFlow
import Core

import Data
import Domain
import MGNetworks

import MGFlow
import HealthKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var mainFlow: HomeFlow!
    let healthStore = HKHealthStore()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        mainFlow = HomeFlow()

        coordinator.coordinate(flow: mainFlow, with: OneStepper(withSingleStep: MGStep.home))
        Flows.use(mainFlow, when: .created) { root in
            self.window?.rootViewController = root
            self.window?.makeKey()
        }
        window?.makeKeyAndVisible()
    }

//    var window: UIWindow?
//    var coordinator = FlowCoordinator()
//
//    func scene(
//        _ scene: UIScene,
//        willConnectTo session: UISceneSession,
//        options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//            window?.rootViewController = MetronomeViewController(
//                viewModel: MetronomeViewModel(metronome: Metronome.sharedInstance)
//            )
////            window?.configure(withRootViewController: TimerViewController(TimerViewModel()))
//        window?.makeKeyAndVisible()
//    }
}
