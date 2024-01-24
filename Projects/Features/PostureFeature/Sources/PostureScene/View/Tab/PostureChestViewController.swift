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

public class PostureChestViewController: BaseViewController<PostureChestViewModel> {
    
    private var chestEntireModel = PostureExerciseModel.chest
    
    private var firstButton = MGToggleButton(type: .bareBody)
    private var secondButton = MGToggleButton(type: .marchine)
    
    private var headerView = UIView()
    
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
        
        postureChestTableView.tableHeaderView = headerView
        view.addSubview(postureChestTableView)
        
        postureChestTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.width.equalToSuperview().inset(8.0)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview().offset(12.0)
        }
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        let input = PostureChestViewModel.Input(firstButtonTapped: firstButton.rx.tap.asObservable(),
                                                secondButtonTapped: secondButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.chestModel
            .subscribe(onNext: { [self] model in
                chestEntireModel = model
                postureChestTableView.reloadData()
            }).disposed(by: disposeBag)
        
        output.firstButtonState
            .subscribe(onNext: { [self] bool in
                switch bool {
                case .checked:
                    firstButton.buttonYesChecked(type: .bareBody)
                case .unchecked:
                    firstButton.buttonNoChecked(type: .bareBody)
                }
            }).disposed(by: disposeBag)
        
        output.secondButtonState
            .subscribe(onNext: { [self] state in
                switch state {
                case .checked:
                    secondButton.buttonYesChecked(type: .marchine)
                case .unchecked:
                    secondButton.buttonNoChecked(type: .marchine)
                }
            }).disposed(by: disposeBag)
    }
}


extension PostureChestViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        
        return 88
    }
}

extension PostureChestViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return chestEntireModel.data.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostureChestTableViewCell.identifier,
            for: indexPath) as? PostureChestTableViewCell
        let exercise = chestEntireModel.data[indexPath.row]
        cell?.setup(exerciseImage: exercise.image, exerciseNameText: exercise.name)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

