import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import DSKit
import MGLogger
import PostureFeatureInterface

public class PostureBackViewController: BaseViewController<PostureBackViewModel> {
    
    private var backEntireModel = PostureExerciseModel.back
    
    private var firstButtonCliked: Bool = false
    private var secondButtonCliked: Bool = false
    
    
    
    private var firstButton = MGToggleButton(type: .bareBody)
    private var secondButton = MGToggleButton(type: .marchine)
    
    private var postureChestTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PostureChestTableViewCell.self,
                    forCellReuseIdentifier: PostureChestTableViewCell.identifier)
    }
    
    public override func attribute() {
        super.attribute()
        
        postureChestTableView.dataSource = self
        postureChestTableView.delegate = self
    }
    
    public override func layout() {
        super.layout()
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(postureChestTableView)
        
        
        firstButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
            $0.top.equalToSuperview().offset(12.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing).offset(8.0)
            $0.top.equalToSuperview().offset(12.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        postureChestTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.width.equalToSuperview().inset(8.0)
            $0.height.equalTo(613.0)
            $0.top.equalTo(secondButton.snp.bottom).offset(12.0)
        }
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        let input = PostureBackViewModel.Input(firstButtonTapped: firstButton.rx.tap.asObservable(),
                                                secondButtonTapped: secondButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.backModel
            .subscribe(onNext: { [weak self] model in
                self?.backEntireModel = model
                self?.postureChestTableView.reloadData()
            }).disposed(by: disposeBag)
        
        output.firstButtonState
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .checked:
                    self?.firstButton.buttonYesChecked(type: .bareBody)
                case .unchecked:
                    self?.firstButton.buttonNoChecked(type: .bareBody)
                }
            }).disposed(by: disposeBag)
        
        output.secondButtonState
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .checked:
                    self?.secondButton.buttonYesChecked(type: .marchine)
                case .unchecked:
                    self?.secondButton.buttonNoChecked(type: .marchine)
                }
            }).disposed(by: disposeBag)
    }
}


extension PostureBackViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        
        return 88
    }
}

extension PostureBackViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return backEntireModel.data.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostureChestTableViewCell.identifier,
            for: indexPath) as? PostureChestTableViewCell
        let exercise = backEntireModel.data[indexPath.row]
        cell?.setup(exerciseImage: exercise.image, exerciseNameText: exercise.name)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

