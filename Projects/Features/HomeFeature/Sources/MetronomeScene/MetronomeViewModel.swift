import UIKit

import RxSwift
import RxCocoa

import SnapKit

import AVFoundation
import AudioToolbox

import HomeFeatureInterface

public protocol MetronomeViewModelDelegate: AnyObject {
    func didUpdateTempo(tempo: Int)
}

public class MetronomeViewModel {
    weak var delegate: MetronomeViewModelDelegate?

    public var isPlaying = false

    public var metronome: MetronomeType
    private let disposeBag = DisposeBag()

    var tempoRelay = BehaviorRelay<Int>(value: 120)
    var tempo: Int {
        get { tempoRelay.value }
        set { tempoRelay.accept(newValue) }
    }
    var beatsRelay = BehaviorRelay<Int>(value: 1)
    var beats: Int {
        get { beatsRelay.value }
        set { beatsRelay.accept(newValue) }
    }

    public init(metronome: MetronomeType, beats: Int = 1) {
        self.metronome = metronome
        self.beats = beats

        tempoRelay
            .subscribe(onNext: { [weak self] tempo in
                self?.delegate?.didUpdateTempo(tempo: tempo)
                if self?.metronome.isPlaying ?? false {
                    self?.metronome.stop()
                    self?.metronome.play(bpm: Double(tempo), beats: self?.beats ?? 1)
                }
            })
            .disposed(by: disposeBag)
    }

    func start() {
        guard !isPlaying else { return }

        isPlaying = true
        metronome.play(bpm: Double(tempo), beats: beats)
    }

    func stop() {
        guard isPlaying else { return }

        isPlaying = false
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
