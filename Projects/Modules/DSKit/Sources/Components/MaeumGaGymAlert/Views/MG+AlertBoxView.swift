import UIKit
import Core

@available(iOS 13, *)
public class MGAlertBoxView: UIView, AlertViewProtocol {
    
    open var dismissByTap: Bool = true
    open var dismissInTime: Bool = true
    open var duration: TimeInterval = 1.5
    open var haptic: AlertHaptic?

    public let titleLabel: UILabel?
    public let subtitleLabel: UILabel?
    public let iconView: UIView?
    
    public static var defaultContentColor = UIColor { trait in
        switch trait.userInterfaceStyle {
        case .dark: return UIColor(red: 127 / 255, green: 127 / 255, blue: 129 / 255, alpha: 1)
        default: return UIColor(red: 88 / 255, green: 87 / 255, blue: 88 / 255, alpha: 1)
        }
    }
    
    fileprivate weak var viewForPresent: UIView?
    fileprivate var presentDismissDuration: TimeInterval = 0.2
    fileprivate var presentDismissScale: CGFloat = 0.8
    
    fileprivate var completion: (() -> Void)?
    
    private lazy var backgroundView: UIVisualEffectView = {
        let view: UIVisualEffectView = {
            return UIVisualEffectView(effect: UIBlurEffect(style: .light))
        }()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public init(title: String? = nil,
                subtitle: String? = nil,
                icon: AlertIcon? = nil) {
        
        if let title = title {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
            label.numberOfLines = 0
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            style.alignment = .center
            label.attributedText = NSAttributedString(string: title, attributes: [.paragraphStyle: style])
            titleLabel = label
        } else {
            self.titleLabel = nil
        }
        if let subtitle = subtitle {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.numberOfLines = 0
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 2
            style.alignment = .center
            label.attributedText = NSAttributedString(string: subtitle, attributes: [.paragraphStyle: style])
            subtitleLabel = label
        } else {
            self.subtitleLabel = nil
        }
        
        if let icon = icon {
            let view = icon.createView(lineThick: 9)
            self.iconView = view
        } else {
            self.iconView = nil
        }
        
        if icon == nil {
            layout = AlertLayout.message()
        } else {
            layout = AlertLayout(for: icon ?? .heart)
        }
        
        self.titleLabel?.textColor = Self.defaultContentColor
        self.subtitleLabel?.textColor = Self.defaultContentColor
        self.iconView?.tintColor = Self.defaultContentColor
        
        super.init(frame: .zero)
        
        preservesSuperviewLayoutMargins = false
        insetsLayoutMarginsFromSafeArea = false
        
        backgroundColor = .clear
        addSubview(backgroundView)
        
        if let titleLabel = self.titleLabel {
            addSubview(titleLabel)
        }
        if let subtitleLabel = self.subtitleLabel {
            addSubview(subtitleLabel)
        }
        if let iconView = self.iconView {
            addSubview(iconView)
        }
        
        layoutMargins = layout.margins
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        
        switch icon {
        case .spinnerSmall, .spinnerLarge:
            dismissInTime = false
            dismissByTap = false
        default:
            dismissInTime = true
            dismissByTap = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func present(on view: UIView, completion: (() -> Void)? = nil) {
        self.viewForPresent = view
        self.completion = completion
        viewForPresent?.addSubview(self)
        guard let viewForPresent = viewForPresent else { return }
        
        alpha = 0
        sizeToFit()
        center = .init(x: viewForPresent.frame.midX, y: viewForPresent.frame.midY)
        transform = transform.scaledBy(x: self.presentDismissScale, y: self.presentDismissScale)
        
        if dismissByTap {
            let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
            addGestureRecognizer(tapGesterRecognizer)
        }
                
        haptic?.impact()
        
        UIView.animate(withDuration: presentDismissDuration, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            
            if let iconView = self.iconView as? AlertIconAnimatable {
                iconView.animate()
            }
            
            if self.dismissInTime {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.duration) {
                    if self.alpha != 0 {
                        self.dismiss()
                    }
                }
            }
        })
    }
    
    @objc open func dismiss() {
        self.dismiss(customCompletion: self.completion)
    }
    
    func dismiss(customCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: presentDismissDuration, animations: {
            self.alpha = 0
            self.transform = self.transform.scaledBy(x: self.presentDismissScale, y: self.presentDismissScale)
        }, completion: { [weak self] _ in
            self?.removeFromSuperview()
            customCompletion?()
        })
    }
    
    private let layout: AlertLayout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.transform == .identity else { return }
        backgroundView.frame = self.bounds
        
        if let iconView = self.iconView {
            iconView.frame = .init(origin: .init(x: 0, y: layoutMargins.top), size: layout.iconSize)
            iconView.center.x = bounds.midX
        }
        if let titleLabel = self.titleLabel {
            titleLabel.layoutDynamicHeight(
                x: layoutMargins.left,
                y: iconView == nil ? layoutMargins.top : (iconView?.frame.maxY ?? 0) + layout.spaceBetweenIconAndTitle,
                width: frame.width - layoutMargins.left - layoutMargins.right)
        }
        if let subtitleLabel = self.subtitleLabel {
            let yPosition: CGFloat = {
                if let titleLabel = self.titleLabel {
                    return titleLabel.frame.maxY + 4
                } else {
                    return layoutMargins.top
                }
            }()
            subtitleLabel.layoutDynamicHeight(x: layoutMargins.left,
                                              y: yPosition,
                                              width: frame.width - layoutMargins.left - layoutMargins.right)
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width: CGFloat = 250
        self.frame = .init(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.height)
        layoutSubviews()
        let height = subtitleLabel?.frame.maxY ?? titleLabel?.frame.maxY ?? iconView?.frame.maxY ?? .zero
        return .init(width: width, height: height + layoutMargins.bottom)
    }
    
    private class AlertLayout {
        
        var iconSize: CGSize
        var margins: UIEdgeInsets
        var spaceBetweenIconAndTitle: CGFloat
        
        public init(iconSize: CGSize, margins: UIEdgeInsets, spaceBetweenIconAndTitle: CGFloat) {
            self.iconSize = iconSize
            self.margins = margins
            self.spaceBetweenIconAndTitle = spaceBetweenIconAndTitle
        }
        
        convenience init() {
            self.init(iconSize: .init(width: 100, height: 100),
                      margins: .init(top: 43, left: 16, bottom: 25, right: 16),
                      spaceBetweenIconAndTitle: 41)
        }
        
        static func message() -> AlertLayout {
            let layout = AlertLayout()
            layout.margins = UIEdgeInsets(top: 23, left: 16, bottom: 23, right: 16)
            return layout
        }
        
        convenience init(for preset: AlertIcon) {
            switch preset {
            case .done:
                self.init(
                    iconSize: .init(width: 112, height: 112),
                    margins: .init(
                        top: 63,
                        left: Self.defaultHorizontalInset,
                        bottom: 29,
                        right: Self.defaultHorizontalInset
                    ),
                    spaceBetweenIconAndTitle: 35
                )
            case .heart:
                self.init(
                    iconSize: .init(width: 112, height: 77),
                    margins: .init(
                        top: 49,
                        left: Self.defaultHorizontalInset,
                        bottom: 25,
                        right: Self.defaultHorizontalInset
                    ),
                    spaceBetweenIconAndTitle: 35
                )
            case .error:
                self.init(
                    iconSize: .init(width: 86, height: 86),
                    margins: .init(
                        top: 63,
                        left: Self.defaultHorizontalInset,
                        bottom: 29,
                        right: Self.defaultHorizontalInset
                    ),
                    spaceBetweenIconAndTitle: 39
                )
            case .spinnerLarge, .spinnerSmall:
                self.init(
                    iconSize: .init(width: 16, height: 16),
                    margins: .init(
                        top: 58,
                        left: Self.defaultHorizontalInset,
                        bottom: 27,
                        right: Self.defaultHorizontalInset
                    ),
                    spaceBetweenIconAndTitle: 39
                )
            case .custom:
                self.init(
                    iconSize: .init(width: 100, height: 100),
                    margins: .init(
                        top: 43,
                        left: Self.defaultHorizontalInset,
                        bottom: 25,
                        right: Self.defaultHorizontalInset
                    ),
                    spaceBetweenIconAndTitle: 35
                )
            }
        }
        
        private static var defaultHorizontalInset: CGFloat { return 16 }
    }
}
