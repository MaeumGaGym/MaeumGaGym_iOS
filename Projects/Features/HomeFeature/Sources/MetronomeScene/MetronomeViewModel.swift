import UIKit

import RxSwift
import RxCocoa

import SnapKit

import AVFoundation
import AudioToolbox

public protocol MetronomeViewModelDelegate: AnyObject {
    func didUpdateTempo(tempo: Int)
}

public class MetronomeViewModel {
    weak var delegate: MetronomeViewModelDelegate?

    private var metronome: MetronomeType
    private let disposeBag = DisposeBag()

    var tempoRelay = BehaviorRelay<Int>(value: 120)
    var tempo: Int {
           get { tempoRelay.value }
           set { tempoRelay.accept(newValue) }
       }

    public init(metronome: MetronomeType) {
        self.metronome = metronome
        tempoRelay
            .subscribe(onNext: { [weak self] tempo in
                self?.delegate?.didUpdateTempo(tempo: tempo)
                // 기존의 start, stop 함수는 tempo의 변화를 감지하지 않으므로, 이 부분에서 재생/정지 로직을 수행해야 함
                if self?.metronome.isPlaying ?? false {
                    self?.metronome.stop()
                    self?.metronome.play(bpm: Double(tempo))
                }
            })
            .disposed(by: disposeBag)
    }

    func start() {
        metronome.play(bpm: Double(tempo))
    }

    func stop() {
        metronome.stop()
    }
}

extension Reactive where Base: MetronomeViewModel {
    var tempo: Binder<Int> {
        return Binder(self.base) { viewModel, tempo in
            viewModel.tempo = tempo
        }
    }
}
