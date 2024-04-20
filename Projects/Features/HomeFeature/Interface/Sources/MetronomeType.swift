import UIKit
import SnapKit
import AVFoundation

public protocol MetronomeType {
    var isPlaying: Bool { get }
    var currentProgressWithinBar: Double { get }
    func play(bpm: Double, beats: Int)
    func stop()
}
