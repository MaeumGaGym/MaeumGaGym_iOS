import UIKit

import RxSwift

import SnapKit
import Then

import DSKit
import Core

import HomeFeatureInterface

public class TimerViewController: BaseViewController<TimerViewModel> {
    
    private var timerData = TimerModel.init()
    private var currentTimerIndex: Int = 0
    
    private var alaertView = TimerAlarmAlertView()
    
    private var navBeforeButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.timerNavLeft.image, for: .normal)
    }
    
    private var navAddButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.timerNavPlus.image, for: .normal)
    }
    
    private var navEditButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.timerNavDots.image, for: .normal)
    }
    
    private var editView = TimerEditView()
    
    private var testView = AddTimerView()
    
    lazy var progressBarView = HomeTimerView(center: view.center, radius: 175.0, color: DSKitAsset.Colors.blue500.color)
    
    private let closeButton = MGTimerButton(type: .close)
    private let stopButton = MGTimerButton(type: .stop, radius: 40.0)
    private let startButton = MGTimerButton(type: .start, radius: 40.0)
    private let restartButton = MGTimerButton(type: .restart)
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var timerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout).then {
        $0.register(TimerHeaderCollectionViewCell.self, forCellWithReuseIdentifier: TimerHeaderCollectionViewCell.identifier)
        $0.register(TimerCollectionViewCell.self, forCellWithReuseIdentifier: TimerCollectionViewCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alaertView.initializeViewPosition()
    }
    
    public override func attribute() {
        view.backgroundColor = .white
        
        progressBarView.timerSetting(for: 0)
        
        buttonTap()
    }
    
    public override func layout() {
        view.addSubviews([navBeforeButton, navAddButton, navEditButton, editView, progressBarView, closeButton, stopButton, startButton, restartButton, timerCollectionView, alaertView, testView])
        
        navBeforeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.height.equalTo(32.0)
        }
        
        navEditButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.width.height.equalTo(32.0)
        }
        
        navAddButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61.0)
            $0.trailing.equalTo(navEditButton.snp.leading).offset(-12.0)
            $0.width.height.equalTo(32.0)
        }
        
        editView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(141.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(350.0)
        }
        
        timerCollectionView.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(49.5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120.0)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(225.0)
            $0.leading.equalToSuperview().offset(83.0)
        }
        
        stopButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)
            
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)
            
        }
        
        restartButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(225.0)
            $0.trailing.equalToSuperview().offset(-83.0)
            
        }
        
        alaertView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(77.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(152.0)
        }
        
        testView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func buttonTap() {
        
        progressBarView.homeTimer.timers[0].timeUpdate
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [self] timeString in
                DispatchQueue.main.async { [self] in
                    if progressBarView.currentTimer(index: currentTimerIndex) <= 0.0 {
                        alaertView.moveViewDown()
                        progressBarView.stopTimer()
                        stopButton.isHidden = true
                        startButton.isHidden = false
                    }
                }
            })
            .disposed(by: disposeBag)
        
        navEditButton.rx.tap
            .subscribe(onNext: { [self] in
                editView.showView()
            }).disposed(by: disposeBag)
        
        startButton.rx.tap
            .subscribe(onNext: { [self] in
                if progressBarView.startTimer() {
                    stopButton.isHidden = false
                    startButton.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        stopButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.stopTimer()
                stopButton.isHidden = true
                startButton.isHidden = false
            })
            .disposed(by: disposeBag)
        
        restartButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.restartTimer()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.cancelTimer()
                alaertView.moveViewDown()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
}

extension TimerViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 40.0, height: 120.0)
        }
        return CGSize(width: 120.0, height: 120.0)
    }
}

extension TimerViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return timerData.data.count + 1
    }
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TimerHeaderCollectionViewCell.identifier,
                for: indexPath
            ) as? TimerHeaderCollectionViewCell
            cell?.setup()
            return cell ?? UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimerCollectionViewCell.identifier,
            for: indexPath
        ) as? TimerCollectionViewCell
        let model = timerData.data[indexPath.row - 1]
        cell?.setup(time: Double(model.time))
        if model.isClicked {
            cell?.cellClicked()
        } else {
            cell?.cellUnClicked()
        }
        return cell ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        
        progressBarView.timerSetting(for: indexPath.row - 1)
        currentTimerIndex = indexPath.row - 1
        
        stopButton.isHidden = true
        startButton.isHidden = false
        
        return true
    }
}


extension TimerViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<timerData.data.count {
            if index == indexPath.row - 1 {
                var newValue = timerData.data[index]
                newValue.isClicked = true
                timerData.updateData(at: index, with: newValue)
            } else {
                var newValue = timerData.data[index]
                newValue.isClicked = false
                timerData.updateData(at: index, with: newValue)
            }
        }
        collectionView.reloadData()
    }
}
import UIKit

import RxSwift

import SnapKit
import Then

import DSKit
import Core

import HomeFeatureInterface

public class TimerViewController: BaseViewController<TimerViewModel> {
    
    private var timerData = TimerModel.init()
    private var currentTimerIndex: Int = 0
    
    private var alaertView = TimerAlarmAlertView()
    
    private var navBeforeButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.timerNavLeft.image, for: .normal)
    }
    
    private var navAddButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.timerNavPlus.image, for: .normal)
    }
    
    private var navEditButton = UIButton().then {
        $0.setImage(DSKitAsset.Assets.timerNavDots.image, for: .normal)
    }
    
    private var editView = TimerEditView()
    
    private var testView = AddTimerView()
    
    lazy var progressBarView = HomeTimerView(center: view.center, radius: 175.0, color: DSKitAsset.Colors.blue500.color)
    
    private let closeButton = MGTimerButton(type: .close)
    private let stopButton = MGTimerButton(type: .stop, radius: 40.0)
    private let startButton = MGTimerButton(type: .start, radius: 40.0)
    private let restartButton = MGTimerButton(type: .restart)
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var timerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout).then {
        $0.register(TimerHeaderCollectionViewCell.self, forCellWithReuseIdentifier: TimerHeaderCollectionViewCell.identifier)
        $0.register(TimerCollectionViewCell.self, forCellWithReuseIdentifier: TimerCollectionViewCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alaertView.initializeViewPosition()
    }
    
    public override func attribute() {
        view.backgroundColor = .white
        
        progressBarView.timerSetting(for: 0)
        
        buttonTap()
    }
    
    public override func layout() {
        view.addSubviews([navBeforeButton, navAddButton, navEditButton, editView, progressBarView, closeButton, stopButton, startButton, restartButton, timerCollectionView, alaertView, testView])
        
        navBeforeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.height.equalTo(32.0)
        }
        
        navEditButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.width.height.equalTo(32.0)
        }
        
        navAddButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61.0)
            $0.trailing.equalTo(navEditButton.snp.leading).offset(-12.0)
            $0.width.height.equalTo(32.0)
        }
        
        editView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(141.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(350.0)
        }
        
        timerCollectionView.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(49.5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120.0)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(225.0)
            $0.leading.equalToSuperview().offset(83.0)
        }
        
        stopButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)
            
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(219.0)
            $0.leading.equalTo(closeButton.snp.trailing).offset(24.0)
            
        }
        
        restartButton.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom).offset(225.0)
            $0.trailing.equalToSuperview().offset(-83.0)
            
        }
        
        alaertView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(77.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(152.0)
        }
        
        testView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func buttonTap() {
        
        progressBarView.homeTimer.timers[0].timeUpdate
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [self] timeString in
                DispatchQueue.main.async { [self] in
                    if progressBarView.currentTimer(index: currentTimerIndex) <= 0.0 {
                        alaertView.moveViewDown()
                        progressBarView.stopTimer()
                        stopButton.isHidden = true
                        startButton.isHidden = false
                    }
                }
            })
            .disposed(by: disposeBag)
        
        navEditButton.rx.tap
            .subscribe(onNext: { [self] in
                editView.showView()
            }).disposed(by: disposeBag)
        
        startButton.rx.tap
            .subscribe(onNext: { [self] in
                if progressBarView.startTimer() {
                    stopButton.isHidden = false
                    startButton.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        stopButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.stopTimer()
                stopButton.isHidden = true
                startButton.isHidden = false
            })
            .disposed(by: disposeBag)
        
        restartButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.restartTimer()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { [self] in
                progressBarView.cancelTimer()
                alaertView.moveViewDown()
                if startButton.isHidden == true {
                    stopButton.isHidden = true
                    startButton.isHidden = false
                }
            }).disposed(by: disposeBag)
    }
}

extension TimerViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 40.0, height: 120.0)
        }
        return CGSize(width: 120.0, height: 120.0)
    }
}

extension TimerViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return timerData.data.count + 1
    }
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TimerHeaderCollectionViewCell.identifier,
                for: indexPath
            ) as? TimerHeaderCollectionViewCell
            cell?.setup()
            return cell ?? UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimerCollectionViewCell.identifier,
            for: indexPath
        ) as? TimerCollectionViewCell
        let model = timerData.data[indexPath.row - 1]
        cell?.setup(time: Double(model.time))
        if model.isClicked {
            cell?.cellClicked()
        } else {
            cell?.cellUnClicked()
        }
        return cell ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        
        progressBarView.timerSetting(for: indexPath.row - 1)
        currentTimerIndex = indexPath.row - 1
        
        stopButton.isHidden = true
        startButton.isHidden = false
        
        return true
    }
}


extension TimerViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<timerData.data.count {
            if index == indexPath.row - 1 {
                var newValue = timerData.data[index]
                newValue.isClicked = true
                timerData.updateData(at: index, with: newValue)
            } else {
                var newValue = timerData.data[index]
                newValue.isClicked = false
                timerData.updateData(at: index, with: newValue)
            }
        }
        collectionView.reloadData()
    }
}
