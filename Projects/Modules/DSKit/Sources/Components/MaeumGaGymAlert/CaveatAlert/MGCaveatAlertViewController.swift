import Foundation
import UIKit

import Then
import SnapKit

import Core

open class MGCaveatAlertViewController: UIViewController {
    private var titleText: String?
    private var messageText: String?
    private var attributedMessageText: NSAttributedString?
    private var contentView: UIView?

    private lazy var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }

    private lazy var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12.0
        $0.alignment = .leading
    }

    private lazy var buttonStackView = UIStackView().then {
        $0.spacing = 14.0
        $0.distribution = .fillEqually
    }

    private lazy var titleLabel: UILabel? = UILabel().then {
        $0.text = titleText
        $0.textAlignment = .center
        $0.font = UIFont.Pretendard.titleMedium
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    private lazy var messageLabel: UILabel? = {
        guard messageText != nil || attributedMessageText != nil else { return nil }

        let label = UILabel()
        label.text = messageText
        label.textAlignment = .left
        label.font = UIFont.Pretendard.labelMedium
        label.textColor = DSKitAsset.Colors.gray700.color
        label.numberOfLines = 0

        if let attributedMessageText = attributedMessageText {
            label.attributedText = attributedMessageText
        }

        return label
    }()

    convenience init(titleText: String? = nil,
                     messageText: String? = nil,
                     attributedMessageText: NSAttributedString? = nil) {
        self.init()

        self.titleText = titleText
        self.messageText = messageText
        self.attributedMessageText = attributedMessageText
        modalPresentationStyle = .overFullScreen
    }

    convenience init(contentView: UIView) {
        self.init()

        self.contentView = contentView
        modalPresentationStyle = .overFullScreen
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addSubviews()
        makeConstraints()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }

    public func addActionToButton(title: String? = nil,
                                  titleColor: UIColor = .white,
                                  backgroundColor: UIColor = .blue,
                                  completion: (() -> Void)? = nil) {
        guard let title = title else { return }

        let button = MGButton(
            titleText: title,
            font: .systemFont(ofSize: 16.0, weight: .bold),
            textColor: .gray
        ).then {
            $0.setBackgroundImage(backgroundColor.image(), for: .normal)
            $0.setBackgroundImage(UIColor.gray.image(), for: .disabled)

            $0.layer.cornerRadius = 4.0
            $0.layer.masksToBounds = true

            $0.addAction(for: .touchUpInside) { _ in
                completion?()
            }
        }

        buttonStackView.addArrangedSubview(button)
    }

    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(containerStackView)
        view.backgroundColor = .black.withAlphaComponent(0.2)
    }

    private func addSubviews() {
        view.addSubview(containerStackView)

        if let contentView = contentView {
            containerStackView.addSubview(contentView)
        } else {
            if let titleLabel = titleLabel {
                containerStackView.addArrangedSubview(titleLabel)
            }

            if let messageLabel = messageLabel {
                containerStackView.addArrangedSubview(messageLabel)
            }
        }

        if let lastView = containerStackView.subviews.last {
            containerStackView.setCustomSpacing(24.0, after: lastView)
        }

        containerStackView.addArrangedSubview(buttonStackView)
    }

    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-26)
            $0.top.greaterThanOrEqualToSuperview().offset(32)
            $0.bottom.lessThanOrEqualToSuperview().offset(-32)
        }

        containerStackView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(24)
            $0.leading.equalTo(containerView.snp.leading).offset(24)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-24)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-24)
        }

        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(containerStackView.snp.width)
        }
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
