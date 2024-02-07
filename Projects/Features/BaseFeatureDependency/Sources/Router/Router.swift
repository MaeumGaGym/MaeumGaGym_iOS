//
//  Router.swift
//  BaseFeatureDependency
//
//  Created by Junho Lee on 2023/06/03.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import UIKit

import Core
import SafariServices

public protocol RouterProtocol: ViewControllable {
    
    var topViewController: UIViewController? { get }
    
    func present(_ module: ViewControllable?)
    func present(_ module: ViewControllable?, animated: Bool)
    func present(_ module: ViewControllable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle)
    func present(_ module: ViewControllable?, animated: Bool, completion: (() -> Void)?)

    func push(_ module: ViewControllable?)
    func push(_ module: ViewControllable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: ViewControllable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ module: ViewControllable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    
    func dismissModule(animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: ViewControllable?, animated: Bool)
    func setRootModule(_ module: ViewControllable?, hideBar: Bool, animated: Bool)
        
    func popToRootModule(animated: Bool)
    func popToModule(module: ViewControllable?, animated: Bool)
    
    func showTitles()
    func hideTitles()
}

public final class Router: NSObject, RouterProtocol {
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?
    
    public var topViewController: UIViewController? {
        self.rootController?.topViewController
    }
    
    // MARK: - ViewControllable
    
    public var viewController: UIViewController {
        return self.rootController ?? UIViewController()
    }
    public var asNavigationController: UINavigationController {
        return rootController ?? UINavigationController(rootViewController: viewController)
    }
    
    // MARK: - RouterProtocol
    
    public func present(_ module: ViewControllable?) {
        self.present(module, animated: true)
    }
    
    public func present(_ module: ViewControllable?, animated: Bool) {
        guard let controller = module?.viewController else { return }
        self.rootController?.present(controller, animated: animated, completion: nil)
    }
    
    public func present(_ module: ViewControllable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle) {
        guard let controller = module?.viewController else { return }
        controller.modalPresentationStyle = modalPresentationSytle
        self.rootController?.present(controller, animated: animated, completion: nil)
    }
    
    public func present(_ module: ViewControllable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle, modalTransitionStyle: UIModalTransitionStyle) {
        guard let controller = module?.viewController else { return }
        controller.modalPresentationStyle = modalPresentationSytle
        controller.modalTransitionStyle = modalTransitionStyle
        self.rootController?.present(controller, animated: animated, completion: nil)
    }
    
    public func present(_ module: ViewControllable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.viewController else { return }
        self.rootController?.present(controller, animated: animated, completion: completion)
    }
    
    public func push(_ module: ViewControllable?)  {
        self.push(module, transition: nil)
    }
    
    public func push(_ module: ViewControllable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(module, transition: transition, animated: true)
    }
    
    public func push(_ module: ViewControllable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        self.push(module, transition: transition, animated: animated, completion: nil)
    }
    
    public func push(_ module: ViewControllable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        self.transition = transition
        
        guard let controller = module?.viewController,
              (controller is UINavigationController == false)
        else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootController?.pushViewController(controller, animated: animated)
        
        self.transition = nil
    }
    
    public func popModule()  {
        self.popModule(transition: nil)
    }
    
    public func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        self.popModule(transition: transition, animated: true)
    }
    
    public func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        
        if let controller = rootController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
        
        self.transition = nil
    }
    
    public func popToModule(module: ViewControllable?, animated: Bool = true) {
        if let controllers = self.rootController?.viewControllers , let module = module {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootController?.popToViewController(controller, animated: animated)
                    self.runCompletion(for: controller)
                    break
                }
            }
        }
    }
    
    public func dismissModule(animated: Bool) {
        self.dismissModule(animated: animated, completion: nil)
    }
    
    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        self.rootController?.dismiss(animated: animated, completion: completion)
    }
    
    public func setRootModule(_ module: ViewControllable?, animated: Bool) {
        self.setRootModule(module, hideBar: false, animated: animated)
    }
    
    public func setRootModule(_ module: ViewControllable?, hideBar: Bool, animated: Bool) {
        guard let controller = module?.viewController else { return }
        self.rootController?.setViewControllers([controller], animated: animated)
        self.rootController?.isNavigationBarHidden = hideBar
    }

    public func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }
    
    public func showTitles() {
        self.rootController?.isNavigationBarHidden = false
        self.rootController?.navigationBar.prefersLargeTitles = true
        self.rootController?.navigationBar.tintColor = UIColor.black
    }
    
    public func hideTitles() {
        self.rootController?.isNavigationBarHidden = true
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

    public init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
        super.init()
    }
}

extension Router: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}
