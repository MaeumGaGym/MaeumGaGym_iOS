import UIKit
import PickleFeatureInterface
import SnapKit
import Then
import DSKit
import Core
import RxSwift
import Pickle

import MGNetworks

struct BottomSheetItem {
    let icon: UIImage
    let title: String
}

public class PickleCell: PickleCollectionViewCell {
    
    private let disposeBag = DisposeBag()
    
    public static let identifier = PickleResourcesService.identifier.pickleCell
        
    let alertView1 = MGAlertOnlyTitleView(title: PickleResourcesService.Title.notSupportingComments).then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
    }
    
    let alertView2 = MGAlertOnlyTitleView(title: PickleResourcesService.Title.underDevelopment).then {
        $0.titleLabel?.font = UIFont.Pretendard.labelMedium
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = DSKitAsset.Colors.gray800.color
    }
    
    private var pickleInfoView = PickleInfoView()
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
    }
        
    private let heartButton = MGOpaqueIconButton(type: .heart)
    private let commentButton = MGOpaqueIconButton(type: .comment)
    private let shareButton = MGOpaqueIconButton(type: .share)
    private let dotButton = MGOpaqueIconButton(type: .dots)

    private let bottomSheetViewController : MGBottomSheetViewController = {
        if #available(iOS 11.0, *) {
            return MGBottomSheetViewController(type: .plain)
        } else {
            return MGBottomSheetViewController(type: .plain)
        }
    }()
    
    private var overlayView: UIView?
    
    private var bottomSheetItems: [BottomSheetItem] = []
    
    
    public override func addSubViews() {
        super.addSubViews()
        
        self.contentView.addSubview(pickleInfoView)
        self.contentView.addSubviews([contentStackView, contentStackView])
        self.contentStackView.addArrangedSubviews(heartButton, commentButton, shareButton, dotButton)
        
        bottomSheetItems = [
            BottomSheetItem(icon: DSKitAsset.Assets.pencil.image, title: "신고")
         ]
        
        bottomSheetViewController.bottomSheetDelegate = self

        let tableView = bottomSheetViewController.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MGBottomSheetIconCell.self, forCellReuseIdentifier: MGBottomSheetIconCell.identifier)
    }
    
    public override func makeConstraints() {
        super.makeConstraints()
        
        pickleInfoView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(180.0)
            $0.bottom.equalToSuperview().offset(-90.0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-105.0)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        heartButton.snp.makeConstraints {
            $0.bottom.equalTo(commentButton.snp.top).offset(-24)
        }
        
        commentButton.snp.makeConstraints {
            $0.bottom.equalTo(shareButton.snp.top).offset(-24)
        }
        
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(dotButton.snp.top).offset(-24)
        }
        
        dotButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
        }
        
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        dotButton.addTarget(self, action: #selector(dotButtonTapped), for: .touchUpInside)
        
        heartButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.hartButtonTapped()
                })
                .disposed(by: disposeBag)
    }
    
    public override func configure(item: PickleItem) {
        super.configure(item: item)
        print("🖤 item: \(item)")
    }
    
    private func hartButtonTapped() {
        print("하트 하트")
        heartButton.isSelected.toggle()
        
        if heartButton.isSelected {
            heartButton.pickleLogoTypeEdit(type: .redHart)
            print("눌림")
        } else {
            heartButton.pickleLogoTypeEdit(type: .heart)
            print("다시 눌림")
        }
    }
    
    @objc private func commentButtonTapped() {
        print("댓글 댓글")
        alertView1.present(on: self)
    }
    
    @objc private func shareButtonTapped() {
        print("공유 공유")
        alertView2.present(on: self)
    }

    
    @objc private func dotButtonTapped() {
        print("나머지 나머지")
        guard let tabBarController = self.findViewController()?.tabBarController else {
            return
        }

        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView?.alpha = 0.0
        overlayView?.isUserInteractionEnabled = true
        self.findViewController()?.view.addSubview(overlayView!)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheet))
        overlayView?.addGestureRecognizer(tapGestureRecognizer)

        UIView.animate(withDuration: 0.3) {
            self.overlayView?.alpha = 1.0
        }

        tabBarController.addChild(self.bottomSheetViewController)
        self.bottomSheetViewController.show(in: tabBarController.view, initialState: .collapsed)
        self.bottomSheetViewController.didMove(toParent: tabBarController)

        let bottomSheetView = self.bottomSheetViewController.view
        bottomSheetView?.layer.shadowColor = UIColor.red.cgColor
        bottomSheetView?.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        bottomSheetView?.layer.shadowRadius = 5
        bottomSheetView?.layer.shadowOpacity = 0.5
    }
    
    @objc private func hideBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView?.alpha = 0.0
        }) { (_) in
            self.overlayView?.removeFromSuperview()
            self.bottomSheetViewController.hideBottomSheet()
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == overlayView {
            hideBottomSheet()
        }
    }
}

extension PickleCell: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomSheetItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MGBottomSheetIconCell.identifier,
            for: indexPath
        ) as? MGBottomSheetIconCell

        let item = bottomSheetItems[indexPath.row]
        cell?.iconImage.image = item.icon
        cell?.mainTitle.text = item.title

        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if bottomSheetViewController.isNavigationBarHidden {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let vc = UIViewController()
        let cell = tableView.cellForRow(at: indexPath)
        vc.title = cell?.textLabel?.text
        vc.view.backgroundColor = .white
        bottomSheetViewController.show(vc, sender: self)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.0
    }
}

extension PickleCell: MGBottomSheetViewDelegate {

    public func didMove(to percentage: Float) {
    }
}
