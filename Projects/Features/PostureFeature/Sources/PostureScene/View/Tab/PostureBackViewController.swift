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
    
    private var firstButton = MGToggleButton(type: .bareBody)
    private var secondButton = MGToggleButton(type: .marchine)
    
    private var headerView = UIView()
    
    private var postureBackTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PostureChestTableViewCell.self,
                    forCellReuseIdentifier: PostureChestTableViewCell.identifier)
    }
    
    public override func attribute() {
        super.attribute()
        
        postureBackTableView.dataSource = self
        postureBackTableView.delegate = self
    }
    
    public override func layout() {
        super.layout()
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        
        headerView.addSubview(firstButton)
        headerView.addSubview(secondButton)

        
        firstButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        secondButton.snp.makeConstraints {
            $0.leading.equalTo(firstButton.snp.trailing).offset(8.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        postureBackTableView.tableHeaderView = headerView
        view.addSubview(postureBackTableView)
        
        postureBackTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.width.equalToSuperview().inset(8.0)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview().offset(12.0)
        }
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        let input = PostureBackViewModel.Input(firstButtonTapped: firstButton.rx.tap.asObservable(),
                                               secondButtonTapped: secondButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.backModel
            .subscribe(onNext: { [self] model in
                backEntireModel = model
                postureBackTableView.reloadData()
            }).disposed(by: disposeBag)
        
        output.firstButtonState
            .subscribe(onNext: { [self] state in
                switch state {
                case .checked:
                    firstButton.buttonYesChecked(type: .bareBody)
                case .unChecked:
                    firstButton.buttonNoChecked(type: .bareBody)
                }
            }).disposed(by: disposeBag)
        
        output.secondButtonState
            .subscribe(onNext: { [self] state in
                switch state {
                case .checked:
                    secondButton.buttonYesChecked(type: .marchine)
                case .unChecked:
                    secondButton.buttonNoChecked(type: .marchine)
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

