import UIKit
import RootFeature
import RxFlow
import RxSwift
import AuthFeature
import RxCocoa

@available(iOS 13.0, *)
class TestSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    let disposeBag = DisposeBag()
    let coordinator = FlowCoordinator()
    lazy var appStepper = AppStepper()
    lazy var appFlow = AppFlow(window: window!)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(loginViewModel)

        let navigationController = UINavigationController(rootViewController: loginViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        coordinator.coordinate(flow: appFlow, with: appStepper)
    }
}
