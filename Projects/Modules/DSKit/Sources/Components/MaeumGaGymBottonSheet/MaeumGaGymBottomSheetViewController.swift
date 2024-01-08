import UIKit
import SnapKit
import Then

public protocol MaeumGaGymBottomSheetViewDelegate {
    func didMove(to percentage: Float)
}

public final class MaeumGaGymBottomSheetViewController: UINavigationController {
    public let rootViewController = MaeumGaGymBottomSheetRootViewController()

    public var tableView: UITableView {
        return rootViewController.tableView
    }
    
    private let dragIndicatorView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray700.color
        $0.layer.cornerRadius = 2
    }
        
    public var state: MaeumGaGymBottomSheetViewState = .collapsed {
        didSet {
            let scrollView = (topViewController?.view as? UIScrollView)
            scrollView?.decelerationRate = UIScrollView.DecelerationRate.fast
            bottomConstraint.constant = constant(of: state)
            bottomSheetDelegate?.didMove(to: 1 - Float(constant(of: state) / constant(of: .collapsed)))
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.view.superview?.layoutIfNeeded()
            }) { (isFinished) in
                scrollView?.decelerationRate = UIScrollView.DecelerationRate.normal
            }
        }
    }
    
    public var heights: (CGFloat, CGFloat, CGFloat) = (1 / 9, 4 / 10, 6 / 7)
    public var bottomSheetDelegate: MaeumGaGymBottomSheetViewDelegate? = nil
    
    private lazy var size: CGSize = {
        guard let superview = view.superview else { return CGSize.zero }
        return superview.bounds.size
    }()
    
    private var bottomConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var lastTranslation = CGPoint.zero
    
    public init(type: MaeumGaGymBottomSheetType) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        
        tableView.separatorStyle = .none
        
        switch type {
        case .plain:
            isNavigationBarHidden = true
        case .navigation(let title):
            rootViewController.navigationItem.largeTitleDisplayMode = .always
            rootViewController.title = title
        }
        
        viewControllers = [rootViewController]
        if let navigationBar = navigationBar as? NavigationBar {
            navigationBar.navigationController = self
            navigationBar.type = type
        }
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    private override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func show(in parentView: UIView, initialState: MaeumGaGymBottomSheetViewState) {
        view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(view)

        let initialConstant = constant(of: initialState)
        bottomConstraint = view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: initialConstant)
        let fullHeight = height(of: .fullyExpanded)
        heightConstraint = view.heightAnchor.constraint(equalToConstant: fullHeight)

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": view as Any]) +
                [bottomConstraint, heightConstraint]
        )

        view.addSubview(dragIndicatorView)
        dragIndicatorView.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(dragIndicatorView.layer.cornerRadius * 2.5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.top).offset(10)
        }

        view.transform = CGAffineTransform(translationX: 0, y: view.frame.height)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }) { _ in
        }

        view.alpha = 0.0
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1.0
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    public func height(of state: MaeumGaGymBottomSheetViewState) -> CGFloat {
        let height: CGFloat
        switch state {
        case .collapsed:
            height = heights.0
        case .partiallyExpanded:
            height = heights.1
        case .fullyExpanded:
            height = heights.2
        }
        if height > 1.0 {
            return height
        } else {
            return size.height * height
        }
    }
    
    private func constant(of state: MaeumGaGymBottomSheetViewState) -> CGFloat {
        switch state {
        case .collapsed:
            return height(of: .fullyExpanded) - height(of: .collapsed)
        case .partiallyExpanded:
            return height(of: .fullyExpanded) - height(of: .partiallyExpanded)
        case .fullyExpanded:
            return 0
        }
    }
    
    @objc private func didPan(sender: UIPanGestureRecognizer) {
        let superview = view.superview
        let scrollView = (topViewController?.view as? UIScrollView)
        let translation = sender.translation(in: superview)
        sender.setTranslation(CGPoint.zero, in: superview)
        
        let topOffset = isNavigationBarHidden ? 0 : navigationBar.frame.height
        let scrollViewDidReachTop: Bool = {
            if let scrollView = scrollView {
                return scrollView.contentOffset.y <= -topOffset
            }
            return true
        }()
        let bottomSheetDidReachBottom = (bottomConstraint.constant == 0)
        let isScrollingDown = translation.y > 0
        let isScrollingUp = translation.y < 0
        
        if isScrollingDown && !scrollViewDidReachTop {
            scrollView?.showsVerticalScrollIndicator = true
            return
        }
        if (isScrollingUp && !bottomSheetDidReachBottom) ||
            (isScrollingDown && scrollViewDidReachTop) {
            scrollView?.setContentOffset(CGPoint(x: 0, y: -topOffset), animated: false)
            scrollView?.showsVerticalScrollIndicator = false
        }
        if isScrollingUp && bottomSheetDidReachBottom {
            scrollView?.showsVerticalScrollIndicator = true
        }
        
        let newConstant = bottomConstraint.constant + translation.y
        switch sender.state {
        case .ended:
            if bottomSheetDidReachBottom {
                return
            }
            
            let isScrollingDown = lastTranslation.y > 0
            let isScrollingUp = lastTranslation.y < 0
            let state: MaeumGaGymBottomSheetViewState
            switch newConstant {
            case constant(of: .fullyExpanded) ..< constant(of: .partiallyExpanded):
                if isScrollingUp {
                    state = .fullyExpanded
                } else if isScrollingDown {
                    state = .partiallyExpanded
                } else {
                    if newConstant > (constant(of: .partiallyExpanded) + constant(of: .fullyExpanded) ) / 2 {
                        state = .partiallyExpanded
                    } else {
                        state = .fullyExpanded
                    }
                }
            case constant(of: .partiallyExpanded) ..< constant(of: .collapsed):
                if isScrollingUp {
                    state = .partiallyExpanded
                } else if isScrollingDown {
                    state = .collapsed
                } else {
                    if newConstant > (constant(of: .partiallyExpanded) + constant(of: .collapsed) ) / 2 {
                        state = .collapsed
                    } else {
                        state = .partiallyExpanded
                    }
                }
            default:
                state = .collapsed
            }
            self.state = state
        default:
            if newConstant <= 0 {
                bottomConstraint.constant = 0
                bottomSheetDelegate?.didMove(to: 1)
            } else {
                bottomConstraint.constant = newConstant
                if constant(of: .collapsed) != 0 {
                    bottomSheetDelegate?.didMove(to: 1 - Float(newConstant / constant(of: .collapsed)))
                } else {
                    bottomSheetDelegate?.didMove(to: -Float(newConstant / height(of: .collapsed)))
                }
            }
        }
        lastTranslation = translation
    }
    
    public func hideBottomSheet(completion: (() -> Void)? = nil) {
        state = .collapsed
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.superview?.layoutIfNeeded()
            self.view.removeFromSuperview()
        }) { (isFinished) in
            completion?()
        }
    }
}

extension MaeumGaGymBottomSheetViewController {
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.size = size
        let fullHeight = height(of: .fullyExpanded)
        heightConstraint.constant = fullHeight
        let state = self.state
        self.state = state
    }
}

extension MaeumGaGymBottomSheetViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
