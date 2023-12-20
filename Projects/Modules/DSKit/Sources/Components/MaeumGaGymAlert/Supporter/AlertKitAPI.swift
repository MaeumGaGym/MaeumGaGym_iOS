import UIKit

public enum AlertKitAPI {
    
    public static func present(view: AlertViewProtocol, completion: @escaping ()->Void = {}) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        view.present(on: window, completion: completion)
    }
    
    public static func present(title: String? = nil, subtitle: String? = nil, icon: AlertIcon? = nil, style: AlertViewStyle, haptic: AlertHaptic? = nil) {
        switch style {
        case .iOS16AppleMusic:
            guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            let view = MaeumGaGymAlertBoxView(title: title, subtitle: subtitle, icon: icon)
            view.haptic = haptic
            view.present(on: window)
        case .iOS17AppleMusic:
            guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            let view = MaeumGaGymAlertBarView(title: title, subtitle: subtitle, icon: icon)
            view.haptic = haptic
            view.present(on: window)
        }
    }

    public static func dismissAllAlerts(completion: (() -> Void)? = nil) {
        
        var alertViews: [AlertViewInternalDismissProtocol] = []
        
        for window in UIApplication.shared.windows {
            for view in window.subviews {
                if let view = view as? AlertViewInternalDismissProtocol {
                    alertViews.append(view)
                }
            }
        }
        
        if alertViews.isEmpty {
            completion?()
        } else {
            for (index, view) in alertViews.enumerated() {
                if index == .zero {
                    view.dismiss(customCompletion: {
                        completion?()
                    })
                } else {
                    view.dismiss(customCompletion: nil)
                }
            }
        }
    }
}
