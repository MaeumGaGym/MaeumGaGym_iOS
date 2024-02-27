import RxFlow
import UIKit
import Then

typealias ViewModelStepper = BaseViewModel & Stepper
typealias ViewModelController = ViewModelProtocol & UIViewController

class FlowSugar<VM, VC>: NSObject where VM: ViewModelStepper, VC: ViewModelController {
    var vm: VM!
    var vc: VC?

    override init() {
        fatalError("init() has not been supported")
    }

    init(viewModel vm: VM) {
        self.vm = vm
        super.init()
    }

    init(_ flow: Flow, _ step: Step) {
    }

    init(_ vm: VM, _ vc: VC.Type) {
        self.vm = vm
        self.vc = VC().then {
            $0.viewModel = vm as? VC.ViewModelType
        }
        super.init()
    }

    func presentable(_ vc: VC.Type) -> Self {
        self.vc = VC().then {
            $0.viewModel = vm as? VC.ViewModelType
        }
        return self
    }
    
    func presentableForStoryBoard(_ vc: VC) -> Self {
        self.vc = vc
        vc.viewModel = vm as? VC.ViewModelType
        return self
    }

    func navigationItem(with block: @escaping (UIViewController) -> Void) -> Self {
        if let vc = self.vc {
            block(vc)
        }
        return self
    }

    func getViewController() -> VC? {
        if let vc = self.vc {
            return vc
        } else {
            return nil
        }
    }

    func setVCProperty(viewControllerBlock block: @escaping (VC) -> Void) -> Self {
        if let vc = self.vc {
            block(vc)
        }
        return self
    }

    func justRegiste() -> FlowContributor? {
        if let vc = self.vc {
            return .contribute(withNextPresentable: vc, withNextStepper: vm)
        }
        return nil
    }

    func oneStepPushBy(_ navi: UINavigationController, isHideBottombar: Bool = false, includeOpaqueBar: Bool = false, animation: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.hidesBottomBarWhenPushed = isHideBottombar
            vc.extendedLayoutIncludesOpaqueBars = includeOpaqueBar
            navi.pushViewController(vc, animated: animation)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }
    
    func oneStepModalPresent(_ parentVC: UIViewController, _ modalStyle: UIModalPresentationStyle = .fullScreen, _ animated: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.modalPresentationStyle = modalStyle
            parentVC.present(vc, animated: animated)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }
    
    func oneStepPopoverPresent(_ parentVC: UIViewController, _ modalStyle: UIModalPresentationStyle = .popover, _ animated: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.modalPresentationStyle = modalStyle
            parentVC.present(vc, animated: animated)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }

    func oneStepModalPresentMakeNavi(_ parentVC: UIViewController, _ modalStyle: UIModalPresentationStyle = .fullScreen, _ animated: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.setNavigationBarHidden(true, animated: true)
            navigationController.modalPresentationStyle = modalStyle
            parentVC.present(navigationController, animated: animated)
            return .one(flowContributor: .contribute(withNextPresentable: navigationController, withNextStepper: vm))
        }
        return .none
    }
}
