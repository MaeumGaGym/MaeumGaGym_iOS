import UIKit

import RxSwift

import SnapKit
import Then

import DSKit
import Core

import HomeFeatureInterface


public class TimerViewController: BaseViewController<TimerViewModel> {
    
    private var timerData = TimerModel.eunho
    
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
    
    
    public override func attribute() {
        view.backgroundColor = .white
        
        progressBarView.timerSetting(for: 3601)
        buttonTap()
    }
    
    public override func layout() {
        view.addSubviews([progressBarView, closeButton, stopButton, startButton, restartButton, timerCollectionView])
        
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
    }
    
    private func buttonTap() {
        
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
        return cell ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        
        let time = timerData.data[indexPath.row - 1].time
        progressBarView.timerSetting(for: time)
        
        stopButton.isHidden = true
        startButton.isHidden = false
        
        return true
    }
}
