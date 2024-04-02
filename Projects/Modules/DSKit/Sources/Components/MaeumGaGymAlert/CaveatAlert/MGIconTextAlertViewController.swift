import Foundation
import UIKit

import RxSwift
import RxCocoa

import Then
import SnapKit

import Core

open class MGIconTextAlertViewController: UIViewController {
    private var titleText: String?
    private var buttonImage: [UIImage]?
    private var buttonText: [String]?
    private var attributedMessageText: NSAttributedString?
    private var contentView: UIView?

    private var firstContainerTapAction: (() -> Void)?
    private var secondContainerTapAction: (() -> Void)?
    
    public var firstButtonTap: ControlEvent<Void> {
        return firstContainerView.rx.tap
    }

    public var secondButtonTap: ControlEvent<Void> {
         return secondContainerView.rx.tap
    }

    private lazy var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
    }
    
    private lazy var titleContainerView = UIView()

    private lazy var titleLabel = UILabel().then {
        $0.text = titleText
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.titleMedium
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    private lazy var firstContainerView = UIButton()
    private lazy var firstImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.blackEarth.image
    }
    
    private lazy var firstLabel = UILabel().then {
        $0.text = buttonText?[0]
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.bodyLarge
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    private lazy var secondContainerView = UIButton()
    private lazy var secondImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.blackImageActIcon.image
    }
    
    private lazy var secondLabel = UILabel().then {
        $0.text = buttonText?[1]
        $0.textAlignment = .left
        $0.font = UIFont.Pretendard.bodyLarge
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    convenience init(titleText: String? = nil,
                     buttonImage: [UIImage]? = nil,
                     buttonText: [String]? = nil,
                     attributedMessageText: NSAttributedString? = nil) {
        self.init()
        
        self.titleText = titleText
        self.buttonText = buttonText
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
        makeConstraints()
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside(_:)))
                view.addGestureRecognizer(tapGesture)
    }

    private func setupViews() {
        view.addSubview(containerView)
        view.backgroundColor = .black.withAlphaComponent(0.2)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }

    private func makeConstraints() {
        view.addSubviews([containerView])
        containerView.addSubviews([titleContainerView,
                                   firstContainerView,
                                   secondContainerView])
        titleContainerView.addSubviews([titleLabel])
        firstContainerView.addSubviews([firstImage, firstLabel])
        secondContainerView.addSubviews([secondImage,
                                         secondLabel])

        containerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(188)
        }

        titleContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
        
        firstContainerView.snp.makeConstraints {
            $0.top.equalTo(titleContainerView.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        firstImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().offset(24.0)
            $0.width.height.equalTo(24.0)
        }
        
        firstLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalTo(firstImage.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview()
        }
        
        secondContainerView.snp.makeConstraints {
            $0.top.equalTo(firstContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24.0)
            $0.height.equalTo(48.0)
        }
        
        secondImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().offset(24.0)
            $0.width.height.equalTo(24.0)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalTo(secondImage.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview()
        }
    }

    @objc private func handleTapOutside(_ gestureRecognizer: UITapGestureRecognizer) {
           let location = gestureRecognizer.location(in: view)
           
           if !containerView.frame.contains(location) {
               dismiss(animated: false, completion: nil)
           }
       }
}
