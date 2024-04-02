import UIKit

public extension UIViewController {
    
    func showIconTextPopUp(title: String? = nil,
                           buttonImages: [UIImage]? = nil,
                           buttonTexts: [String]? = nil,
                           attributedMessage: NSAttributedString? = nil,
                           leftActionCompletion: (() -> Void)? = nil,
                           rightActionCompletion: (() -> Void)? = nil) {
        
        let popUpViewController = MGIconTextAlertViewController(titleText: title,
                                                                buttonImage: buttonImages,
                                                                buttonText: buttonTexts,
                                                                attributedMessageText: attributedMessage)

        present(popUpViewController, animated: false, completion: nil)
    }
    
    func showCaveatPopUp(
        title: String? = nil,
        message: String? = nil,
        attributedMessage: NSAttributedString? = nil,
        leftActionTitle: String? = "취소",
        rightActionTitle: String = "확인",
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil) {
            
            let popUpViewController = MGCaveatAlertViewController(titleText: title,
                                                                  messageText: message,
                                                                  attributedMessageText: attributedMessage)
            showCaveatPopUp(popUpViewController: popUpViewController,
                            leftActionTitle: leftActionTitle,
                            rightActionTitle: rightActionTitle,
                            leftActionCompletion: leftActionCompletion,
                            rightActionCompletion: rightActionCompletion)
        }
    
    func showCaveatPopUp(
        contentView: UIView,
        leftActionTitle: String? = "취소",
        rightActionTitle: String = "확인",
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil) {
            let popUpViewController = MGCaveatAlertViewController(contentView: contentView)
            
            showCaveatPopUp(popUpViewController: popUpViewController,
                            leftActionTitle: leftActionTitle,
                            rightActionTitle: rightActionTitle,
                            leftActionCompletion: leftActionCompletion,
                            rightActionCompletion: rightActionCompletion)
        }

    private func showCaveatPopUp(
        popUpViewController: MGCaveatAlertViewController,
        leftActionTitle: String?,
        rightActionTitle: String,
        leftActionCompletion: (() -> Void)?,
        rightActionCompletion: (() -> Void)?) {
            popUpViewController.addActionToButton(title: leftActionTitle,
                                                  titleColor: DSKitAsset.Colors.red500.color,
                                                  backgroundColor: DSKitAsset.Colors.red50.color) {
                popUpViewController.dismiss(animated: false, completion: leftActionCompletion)
            }
            
            popUpViewController.addActionToButton(title: rightActionTitle,
                                                  titleColor: .white,
                                                  backgroundColor: DSKitAsset.Colors.red500.color) {
                popUpViewController.dismiss(animated: false, completion: rightActionCompletion)
            }
            present(popUpViewController, animated: false, completion: nil)
        }
}
