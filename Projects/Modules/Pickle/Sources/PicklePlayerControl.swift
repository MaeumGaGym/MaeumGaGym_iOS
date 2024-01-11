import Foundation

final class PicklePlayerControl {
    
    struct Parameter {
        let isPlay: Bool
        let priority: Priority
        let didSelect: Bool
    }
    
    var isPlay: Bool = false
    var isPlayFromHigh = true
    var delegate: PlayerControlDelegate?
    
    private func setVideoControl(parameter: Parameter) {
        switch parameter.priority {
        case .high:
            self.isPlay = parameter.isPlay
            self.isPlayFromHigh = parameter.isPlay
        case .low:
            guard self.isPlayFromHigh else {
                return
            }
            self.isPlay = parameter.isPlay
        }
        
        if self.isPlay {
            self.delegate?.play(priority: parameter.priority, didSelect: parameter.didSelect)
        } else {
            self.delegate?.pause(priority: parameter.priority, didSelect: parameter.didSelect)
        }
    }
}

extension PicklePlayerControl: PlayerControl {
    func play(priority: Priority) {
        self.setVideoControl(
            parameter: .init(
                isPlay: true,
                priority: priority,
                didSelect: false
            )
        )
    }
    
    func pause(priority: Priority) {
        self.setVideoControl(
            parameter: .init(
                isPlay: false,
                priority: priority,
                didSelect: false
            )
        )
    }
    
    func refresh() {
        self.setVideoControl(
            parameter: .init(
                isPlay: self.isPlayFromHigh,
                priority: .high,
                didSelect: false
            )
        )
    }
    
    func toggle(priority: Priority, didSelect: Bool) {
        self.setVideoControl(
            parameter: .init(
                isPlay: !self.isPlay,
                priority: .low,
                didSelect: didSelect
            )
        )
    }
}
