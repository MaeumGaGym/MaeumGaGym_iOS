import UIKit
import Then

public class MaeumGaGymAlertOnlyTitleView: UIView, AlertViewProtocol, AlertViewInternalDismissProtocol {

    open var dismissByTap: Bool = true
    open var dismissInTime: Bool = true
    open var duration: TimeInterval = 1.5
    open var haptic: AlertHaptic? = nil
    
    private let fixedHeight: CGFloat = 42.0

    public let titleLabel: UILabel?

    public static var defaultContentColor = UIColor { trait in
        switch trait.userInterfaceStyle {
        case .dark: return UIColor(red: 127 / 255, green: 127 / 255, blue: 129 / 255, alpha: 1)
        default: return UIColor(red: 88 / 255, green: 87 / 255, blue: 88 / 255, alpha: 1)
        }
    }

    fileprivate weak var viewForPresent: UIView?
    fileprivate var presentDismissDuration: TimeInterval = 0.5
    fileprivate var presentDismissScale: CGFloat = 0.8

    fileprivate var completion: (()->Void)? = nil

    private lazy var backgroundView: UIView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        view.isUserInteractionEnabled = false
        return view
    }()

    public init(title: String?) {
        titleLabel = UILabel().then {
            $0.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold, addPoints: -2)
            $0.numberOfLines = 0
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            style.alignment = .left
            $0.attributedText = NSAttributedString(string: title ?? "", attributes: [.paragraphStyle: style])
        }

        self.titleLabel?.textColor = Self.defaultContentColor

        super.init(frame: .zero)

        preservesSuperviewLayoutMargins = false //슈퍼뷰의 여백을 묻는 코드 //기본 false //나중에 프레임이 딱 맞아야하는 상황을 위해 사용
        insetsLayoutMarginsFromSafeArea = false

        backgroundColor = .clear
        addSubview(backgroundView)

        if let titleLabel = self.titleLabel {
            addSubview(titleLabel)
        }

        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func present(on view: UIView, completion: (() -> Void)? = nil) {
        self.viewForPresent = view
        self.completion = completion
        viewForPresent?.addSubview(self) // 현재 뷰의 추가하는 코드
        guard let viewForPresent = viewForPresent else { return }

        alpha = 0
        sizeToFit()
        center.x = viewForPresent.frame.midX
        frame.origin.y = viewForPresent.safeAreaInsets.top

        transform = transform.scaledBy(x: self.presentDismissScale, y: self.presentDismissScale) // 지정된 비율로 축소 시키는 코드

        if dismissByTap { // 클릭하면 내려가도록 설명
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
            addGestureRecognizer(tapGestureRecognizer)
        }
        
        UIView.animate(withDuration: presentDismissDuration, animations: {
            self.alpha = 1 // 뷰가 나타나는 효과
            self.transform = CGAffineTransform.identity //원래 크기로 만드는 코드
        }, completion: { [weak self] finished in
            guard let self = self else { return } // 메모리 안전성

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

    func dismiss(customCompletion: (()->Void)? = nil) {
        UIView.animate(withDuration: presentDismissDuration, animations: {
            self.alpha = 0
            self.transform = self.transform.scaledBy(x: self.presentDismissScale, y: self.presentDismissScale)
        }, completion: { [weak self] finished in
            self?.removeFromSuperview() // 뷰에서 삭제 시키는 코드
            customCompletion?()
        })
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        guard self.transform == .identity else { return }
        backgroundView.frame = self.bounds
        center.x = viewForPresent?.frame.midX ?? 0
        
        layout(maxWidth: frame.width)
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let fixedWidth: CGFloat = 390.0
        let fixedHeight: CGFloat = 42.0
        layout(maxWidth: fixedWidth)

        let maxX = subviews.sorted(by: { $0.frame.maxX > $1.frame.maxX }).first?.frame.maxX ?? .zero
        let currentNeedWidth = maxX + layoutMargins.right

        let usingWidth = min(currentNeedWidth, fixedWidth)
        layout(maxWidth: usingWidth)
        let height = fixedHeight
        return .init(width: usingWidth, height: height + layoutMargins.bottom)
    }

    private func layout(maxWidth: CGFloat?) {
        let leadingMargin: CGFloat = 0.0
        let trailingMargin: CGFloat = 24.0

        let availableWidth = maxWidth ?? 390.0
        let labelWidth = availableWidth - leadingMargin - trailingMargin
        titleLabel?.frame = CGRect(
            x: leadingMargin + layoutMargins.left,
            y: layoutMargins.top - 3,
            width: labelWidth,
            height: fixedHeight
        )
    }
}
