import UIKit
import SnapKit
import AVFoundation

public protocol MetronomeViewModelDelegate: AnyObject {
    func didUpdateTempo(tempo: Int)
}

public class MetronomeViewModel {
    weak var delegate: MetronomeViewModelDelegate?

    private var metronome: MetronomeType
    var tempo: Int = 120 {
        didSet {
            delegate?.didUpdateTempo(tempo: tempo)
        }
    }

    public init(metronome: MetronomeType) {
        self.metronome = metronome
    }

    func start() {
        metronome.play(bpm: Double(tempo))
    }

    func stop() {
        metronome.stop()
    }
}
