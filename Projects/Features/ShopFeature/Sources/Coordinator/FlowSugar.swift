import RxFlow
import Core
import UIKit
import Then

public typealias ViewModelStepper = BaseViewModel & Stepper
public typealias ViewModelController = ViewModelProtocol & UIViewController

public class FlowSugar<VM, VC>: NSObject where VM: ViewModelStepper, VC: ViewModelController {
    var vm: VM!
    var vc: VC?

    public override init() {
        fatalError("init() has not been supported")
    }

    public init(viewModel vm: VM) {
        self.vm = vm
        super.init()
    }

    public init(_ flow: Flow, _ step: Step) {
    }

    public init(_ vm: VM, _ vc: VC.Type) {
        self.vm = vm
        self.vc = VC().then {
            $0.viewModel = vm as? VC.ViewModelType
        }
        super.init()
    }

    public func presentable(_ vc: VC.Type) -> Self {
        self.vc = VC().then {
            $0.viewModel = vm as? VC.ViewModelType
        }
        return self
    }
    
    public func presentableForStoryBoard(_ vc: VC) -> Self {
        self.vc = vc
        vc.viewModel = vm as? VC.ViewModelType
        return self
    }

    public func navigationItem(with block: @escaping (UIViewController) -> Void) -> Self {
        if let vc = self.vc {
            block(vc)
        }
        return self
    }

    public func getViewController() -> VC? {
        if let vc = self.vc {
            return vc
        } else {
            return nil
        }
    }

    public func setVCProperty(viewControllerBlock block: @escaping (VC) -> Void) -> Self {
        if let vc = self.vc {
            block(vc)
        }
        return self
    }

    public func justRegiste() -> FlowContributor? {
        if let vc = self.vc {
            return .contribute(withNextPresentable: vc, withNextStepper: vm)
        }
        return nil
    }

    public func oneStepPushBy(_ navi: UINavigationController, isHideBottombar: Bool = false, includeOpaqueBar: Bool = false, animation: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.hidesBottomBarWhenPushed = isHideBottombar
            vc.extendedLayoutIncludesOpaqueBars = includeOpaqueBar
            navi.pushViewController(vc, animated: animation)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }
    
    public func oneStepModalPresent(_ parentVC: UIViewController, _ modalStyle: UIModalPresentationStyle = .fullScreen, _ animated: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.modalPresentationStyle = modalStyle
            parentVC.present(vc, animated: animated)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }
    
    public func oneStepPopoverPresent(_ parentVC: UIViewController, _ modalStyle: UIModalPresentationStyle = .popover, _ animated: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.modalPresentationStyle = modalStyle
            parentVC.present(vc, animated: animated)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }

    public func oneStepModalPresentMakeNavi(_ parentVC: UIViewController, _ modalStyle: UIModalPresentationStyle = .fullScreen, _ animated: Bool = true) -> FlowContributors {
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
