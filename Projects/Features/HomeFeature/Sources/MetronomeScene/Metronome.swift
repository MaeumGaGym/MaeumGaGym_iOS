import UIKit
import SnapKit
import AVFoundation
import AudioToolbox
import HomeFeatureInterface

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

    public func play(bpm: Double, beats: Int) {
        let buffer = generateBuffer(bpm: bpm, beats: beats)

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

    private func generateBuffer(bpm: Double, beats: Int) -> AVAudioPCMBuffer {
        audioFileMainClick.framePosition = 0
        audioFileAccentedClick.framePosition = 0

        let beatLength = AVAudioFrameCount(audioFileMainClick.processingFormat.sampleRate * 60 / bpm)
        let barLength = beatLength * UInt32(beats)

        guard let bufferMainClick = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat,
                                                     frameCapacity: beatLength
        ) else {
            fatalError("기본 클릭에 대한 AVAudioPCMBuffer를 생성하지 못했습니다")
        }

        do {
            try audioFileMainClick.read(into: bufferMainClick)
            bufferMainClick.frameLength = beatLength
        } catch {
            fatalError("클릭 오디오 파일을 읽지 못했습니다: \(error)")
        }

        guard let bufferAccentedClick = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat,
                                                         frameCapacity: beatLength
        ) else {
            fatalError("인증된 클릭에 대한 AVAudioPCMBuffer를 생성하지 못했습니다")
        }

        do {
            try audioFileAccentedClick.read(into: bufferAccentedClick)
            bufferAccentedClick.frameLength = beatLength
        } catch {
            fatalError("클릭 오디오 파일을 읽지 못했습니다: \(error)")
        }

        guard let bufferBar = AVAudioPCMBuffer(pcmFormat: audioFileMainClick.processingFormat,
                                               frameCapacity: barLength) else {
            fatalError("바에 대한 AVAudioPCMBuffer를 생성하지 못했습니다")
        }

        let channelCount = Int(audioFileMainClick.processingFormat.channelCount)
        let accentedClickArray = Array(UnsafeBufferPointer(start: bufferAccentedClick.floatChannelData![0],
                                                           count: channelCount * Int(beatLength)))
        let mainClickArray = Array(UnsafeBufferPointer(start: bufferMainClick.floatChannelData![0],
                                                       count: channelCount * Int(beatLength)))

        var barArray = [Float]()

        if beats == 1 {
            barArray.append(contentsOf: accentedClickArray)
        } else {
            barArray.append(contentsOf: accentedClickArray)
            for _ in 1..<beats {
                barArray.append(contentsOf: mainClickArray)
            }
        }

        let bufferPointer = bufferBar.floatChannelData![0]
        bufferPointer.initialize(from: barArray, count: barArray.count)

        bufferBar.frameLength = AVAudioFrameCount(barArray.count)

        return bufferBar
    }
}
