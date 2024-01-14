import UIKit
import DSKit
import SnapKit
import Then
import RxSwift
import RxCocoa

public class DSToggleButtonVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var image = MaeumGaGymToggleButton(type: .image)
    var album = MaeumGaGymToggleButton(type: .album)
    var metronome = MaeumGaGymToggleButton(type: .metronome)
    var timer = MaeumGaGymToggleButton(type: .timer)
    var metronome1 = MaeumGaGymToggleButton(type: .metronomeHome)
    var timer1 = MaeumGaGymToggleButton(type: .timerHome)
    var morning = MaeumGaGymToggleButton(type: .morning)
    var lunch = MaeumGaGymToggleButton(type: .lunch)
    var dinner = MaeumGaGymToggleButton(type: .dinner)
    var bareBody = MaeumGaGymToggleButton(type: .bareBody)
    var marchine = MaeumGaGymToggleButton(type: .marchine)


    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        bind()
    }
    
    func layout() {
        [
            image,
            album,
            metronome,
            timer,
            metronome1,
            timer1,
            morning,
            lunch,
            dinner,
            bareBody,
            marchine
        ].forEach { view.addSubview($0) }
        
        image.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(83.0)
            $0.height.equalTo(40.0)
        }
        
        album.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(83.0)
            $0.height.equalTo(40.0)
        }
        
        timer.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(92.0)
            $0.height.equalTo(40.0)
        }
        
        metronome.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(92.0)
            $0.height.equalTo(40.0)
        }
        
        timer1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(78.0)
            $0.height.equalTo(32.0)
        }
        
        metronome1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(78.0)
            $0.height.equalTo(32.0)
        }
        
        morning.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(300.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(64.0)
            $0.height.equalTo(32.0)
        }
        
        lunch.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(300.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(64.0)
            $0.height.equalTo(32.0)
        }
        
        dinner.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(300.0)
            $0.leading.equalToSuperview().offset(220.0)
            $0.width.equalTo(64.0)
            $0.height.equalTo(32.0)
        }
        
        bareBody.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(400.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
        
        marchine.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(400.0)
            $0.leading.equalToSuperview().offset(120.0)
            $0.width.equalTo(60.0)
            $0.height.equalTo(36.0)
        }
    }
    
    func bind() {
        image.buttonYesChecked(type: .image)
        timer.buttonYesChecked(type: .timer)
        timer1.buttonYesChecked(type: .timerHome)
        morning.buttonYesChecked(type: .morning)
        bareBody.buttonYesChecked(type: .bareBody)

        image.rx.tap
            .subscribe(onNext: {
                self.image.buttonYesChecked(type: .image)
                self.album.buttonNoChecked(type: .album)
            }).disposed(by: disposeBag)
        
        album.rx.tap
            .subscribe(onNext: {
                self.album.buttonYesChecked(type: .album)
                self.image.buttonNoChecked(type: .image)
            }).disposed(by: disposeBag)
        
        timer.rx.tap
            .subscribe(onNext: {
                self.timer.buttonYesChecked(type: .timer)
                self.metronome.buttonNoChecked(type: .metronome)
            }).disposed(by: disposeBag)
        
        metronome.rx.tap
            .subscribe(onNext: {
                self.metronome.buttonYesChecked(type: .metronome)
                self.timer.buttonNoChecked(type: .timer)
            }).disposed(by: disposeBag)
        
        timer1.rx.tap
            .subscribe(onNext: {
                self.timer1.buttonYesChecked(type: .timerHome)
                self.metronome1.buttonNoChecked(type: .metronomeHome)
            }).disposed(by: disposeBag)
        
        metronome1.rx.tap
            .subscribe(onNext: {
                self.metronome1.buttonYesChecked(type: .metronomeHome)
                self.timer1.buttonNoChecked(type: .timerHome)
            }).disposed(by: disposeBag)
        
        morning.rx.tap
            .subscribe(onNext: {
                self.morning.buttonYesChecked(type: .morning)
                self.lunch.buttonNoChecked(type: .lunch)
                self.dinner.buttonNoChecked(type: .dinner)
            }).disposed(by: disposeBag)
        
        
        lunch.rx.tap
            .subscribe(onNext: {
                self.lunch.buttonYesChecked(type: .lunch)
                self.morning.buttonNoChecked(type: .morning)
                self.dinner.buttonNoChecked(type: .dinner)
            }).disposed(by: disposeBag)
        
        dinner.rx.tap
            .subscribe(onNext: {
                self.dinner.buttonYesChecked(type: .dinner)
                self.morning.buttonNoChecked(type: .morning)
                self.lunch.buttonNoChecked(type: .lunch)
            }).disposed(by: disposeBag)
        
        bareBody.rx.tap
            .subscribe(onNext: {
                self.bareBody.buttonYesChecked(type: .bareBody)
                self.marchine.buttonNoChecked(type: .marchine)
            }).disposed(by: disposeBag)
        
        marchine.rx.tap
            .subscribe(onNext: {
                self.marchine.buttonYesChecked(type: .marchine)
                self.bareBody.buttonNoChecked(type: .bareBody)
            }).disposed(by: disposeBag)
    }
}
