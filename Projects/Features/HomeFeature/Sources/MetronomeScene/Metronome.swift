import UIKit
import SnapKit
import AVFoundation
import AudioToolbox

public class Metronome: MetronomeType {
    public static let sharedInstance = Metronome(
        mainClickFile: Bundle.main.url(
            forResource: "Low", withExtension: "wav"
        )!,
        accentedClickFile: Bundle.main.url(
            forResource: "High", withExtension: "wav"
        )!
    )

    private let audioPlayerNode: AVAudioPlayerNode
    private let audioFileMainClick: AVAudioFile
    private let audioFileAccentedClick: AVAudioFile
    private let audioEngine: AVAudioEngine

    private var currentBuffer: AVAudioPCMBuffer?

    init(mainClickFile: URL, accentedClickFile: URL? = nil) {
        do {
            audioFileMainClick = try AVAudioFile(forReading: mainClickFile)
            audioFileAccentedClick = try AVAudioFile(forReading: accentedClickFile ?? mainClickFile)
        } catch {
            fatalError("Failed to create AVAudioFile: \(error)")
        }

        audioPlayerNode = AVAudioPlayerNode()

        audioEngine = AVAudioEngine()
        audioEngine.attach(self.audioPlayerNode)

        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: audioFileMainClick.processingFormat)

        do {
            try audioEngine.start()
        } catch {
            fatalError("Failed to start audio engine: \(error)")
        }
    }

    public func stop() {
        audioPlayerNode.stop()
    }

    public var isPlaying: Bool {
        audioPlayerNode.isPlaying
    }

    public func play(bpm: Double) {
        let buffer = generateBuffer(bpm: bpm)

        currentBuffer = buffer

        if audioPlayerNode.isPlaying {
            audioPlayerNode.stop()
        }

        audioPlayerNode.play()

        audioPlayerNode.scheduleBuffer(
            buffer,
            at: nil,
            options: [.interruptsAtLoop, .loops]
        )
    }

    public var currentProgressWithinBar: Double {
        guard let nodeTime = audioPlayerNode.lastRenderTime,
              let playerTime = audioPlayerNode.playerTime(forNodeTime: nodeTime),
              let buffer = currentBuffer else {
            return 0
        }

        return Double(playerTime.sampleTime)
            .truncatingRemainder(dividingBy: Double(buffer.frameLength))
        / Double(buffer.frameLength)
    }

    private func generateBuffer(bpm: Double) -> AVAudioPCMBuffer {
        audioFileMainClick.framePosition = 0
        audioFileAccentedClick.framePosition = 0

        let beatLength = AVAudioFrameCount(audioFileMainClick.processingFormat.sampleRate * 60 / bpm)
        guard let bufferMainClick = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat, frameCapacity: beatLength) else {
            fatalError("Failed to create AVAudioPCMBuffer for main click")
        }

        do {
            try audioFileMainClick.read(into: bufferMainClick)
            bufferMainClick.frameLength = beatLength
        } catch {
            fatalError("Failed to read main click audio file: \(error)")
        }

        guard let bufferAccentedClick = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat, frameCapacity: beatLength) else {
            fatalError("Failed to create AVAudioPCMBuffer for accented click")
        }

        do {
            try audioFileAccentedClick.read(into: bufferAccentedClick)
            bufferAccentedClick.frameLength = beatLength
        } catch {
            fatalError("Failed to read accented click audio file: \(error)")
        }

        let bufferBar = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat, frameCapacity: 4 * beatLength)!
        bufferBar.frameLength = 4 * beatLength

        let channelCount = Int(audioFileMainClick.processingFormat.channelCount)
        let accentedClickArray = Array(UnsafeBufferPointer(start: bufferAccentedClick.floatChannelData![0], count: channelCount * Int(beatLength)))
        let mainClickArray = Array(UnsafeBufferPointer(start: bufferMainClick.floatChannelData![0], count: channelCount * Int(beatLength)))

        var barArray = [Float]()
        barArray.append(contentsOf: accentedClickArray)
        for _ in 1...3 {
            barArray.append(contentsOf: mainClickArray)
        }

        let bufferPointer = bufferBar.floatChannelData![0]
        bufferPointer.initialize(from: barArray, count: barArray.count)

        return bufferBar
    }
}
