import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DSKit
import Domain

public class MGSelfCareTargetBottomSheetAlertView: UIViewController {

    private let disposeBag = DisposeBag()

    public var editButtonTap: () -> Void
    public var deleteButtonTap: () -> Void

    private let targetEditButton = MGButton(titleText: "수정", image: .pencilActIcon).then {
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    private let targetDeleteButton = MGButton(titleText: "삭제", image: .trashActIcon).then {
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
    }

    public init(
        editButtonTap: @escaping () -> Void,
        deleteButtonTap: @escaping () -> Void
    ) {
        self.editButtonTap = editButtonTap
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
        targetEditButton.rx.tap
            .bind { [weak self] in
                self?.editButtonTap()
            }.disposed(by: disposeBag)

        targetDeleteButton.rx.tap
            .bind { [weak self] in
                self?.deleteButtonTap()
            }.disposed(by: disposeBag)

    }
    private func layout() {
        view.addSubviews([
            targetEditButton,
            targetDeleteButton
        ])

        targetEditButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        targetDeleteButton.snp.makeConstraints {
            $0.top.equalTo(targetEditButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
    }

}
