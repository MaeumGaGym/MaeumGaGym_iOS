import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DSKit
import Domain

public class MGSelfCareRoutineBottomSheet: UIViewController {

    private let disposeBag = DisposeBag()

    public var editButtonTap: () -> Void
    public var storageButtonTap: () -> Void
    public var shareButtonTap: () -> Void
    public var deleteButtonTap: () -> Void

    private let routineEditButton = MGButton(titleText: "수정", image: .pencilActIcon).then {
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    private let routineStorageButton = MGButton(titleText: "보관", image: .blackImageActIcon).then {
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    private let routineShareButton = MGButton(titleText: "공유", image: .blackEarth).then {
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    private let routineDeleteButton = MGButton(titleText: "삭제", image: .trashActIcon).then {
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
    }

    public init(
        editButtonTap: @escaping () -> Void, 
        storageButtonTap: @escaping () -> Void,
        shareButtonTap: @escaping () -> Void, 
        deleteButtonTap: @escaping () -> Void
    ) {
        self.editButtonTap = editButtonTap
        self.storageButtonTap = storageButtonTap
        self.shareButtonTap = shareButtonTap
        self.deleteButtonTap = deleteButtonTap
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        bindActions()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layout()
    }

    private func bindActions() {
        routineEditButton.rx.tap
            .bind { [weak self] in
                self?.editButtonTap()
            }.disposed(by: disposeBag)
        
        routineStorageButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: {
                    self?.storageButtonTap()
                })
            }.disposed(by: disposeBag)
        
        routineShareButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: {
                    self?.shareButtonTap()
                })
            }.disposed(by: disposeBag)

        routineDeleteButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: {
                    self?.deleteButtonTap()
                })
            }.disposed(by: disposeBag)

    }
    private func layout() {
        view.addSubviews([
            routineEditButton,
            routineStorageButton,
            routineShareButton,
            routineDeleteButton
        ])

        routineEditButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        routineStorageButton.snp.makeConstraints {
            $0.top.equalTo(routineEditButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        routineShareButton.snp.makeConstraints {
            $0.top.equalTo(routineStorageButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        routineDeleteButton.snp.makeConstraints {
            $0.top.equalTo(routineShareButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
    }

}
