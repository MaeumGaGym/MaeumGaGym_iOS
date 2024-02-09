import UIKit
import SnapKit
import AVFoundation

public class Metronome: NSObject, MetronomeType {
    static let sharedInstance = Metronome()

    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    private var bpm: Double = 120
    private var beatCount: Int = 0
    private var isPlayingInternal = false

    public var isPlaying: Bool {
        return isPlayingInternal
    }

    public var currentProgressWithinBar: Double {
        guard let player = audioPlayer else { return 0.0 }
        return Double(player.currentTime / player.duration)
    }

    public override init() {
        super.init()
        setupAudioPlayer()
    }

    private func setupAudioPlayer() {
        guard let url = Bundle.main.url(forResource: "High", withExtension: "wav") else {
            fatalError("Sound file not found")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
        } catch {
            fatalError("Failed to create audio player: \(error)")
        }
    }

    public func play(bpm: Double) {
        stop()
        self.bpm = bpm
        beatCount = 0
        isPlayingInternal = true
        startTimer()
    }

    public func stop() {
        timer?.invalidate()
        audioPlayer?.stop()
        isPlayingInternal = false
    }

    private func startTimer() {
        guard let player = audioPlayer else { return }
        let interval = 60.0 / bpm

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            if self.beatCount == 0 {
                player.play()
            }

            self.beatCount = (self.beatCount + 1) % 4
        }
    }
}

extension Metronome: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Implement if needed
    }
}
