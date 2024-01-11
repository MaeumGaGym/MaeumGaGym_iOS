import UIKit
import Core
import AVFoundation

final class PicklePlayerView: UIView {
    
    let thumnailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let queuePlayer: AVQueuePlayer = {
        let player = AVQueuePlayer()
        return player
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.videoGravity = .resizeAspect
        layer.player = self.queuePlayer
        return layer
    }()
    
    private var loop: AVPlayerLooper?
    private var isPlayAfterLoad: Bool = false
    private var observerList: [NSKeyValueObservation] = []
    var didMakeConstraints: Bool = false
    
    init() {
        defer {
            self.backgroundColor = .clear
            self.makeLayout()
        }
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer.frame = self.bounds
    }
    
    func reset() {
        self.pause()
        self.thumnailImageView.image = nil
        self.observerList.removeAll()
        self.loop = nil
        self.queuePlayer.removeAllItems()
    }
    
    private func insertItem(asset: AVAsset) {
        let playItem = AVPlayerItem(asset: asset)
        if self.queuePlayer.items().isEmpty,
           self.queuePlayer.canInsert(playItem, after: nil) {
            self.queuePlayer.insert(
                playItem,
                after: nil
            )
        }
    }
    
    private func addObserve(item: AVPlayerItem) {
        let observer = item.observe(\.status, options: [.old, .new]) { [weak self] (
            item: AVPlayerItem,
            change: NSKeyValueObservedChange<AVPlayerItem.Status>
        ) in
            guard let `self` = self else {
                return
            }
            switch item.status {
            case .readyToPlay:
                if self.isPlayAfterLoad {
                    self.queuePlayer.play()
                    self.isPlayAfterLoad = false
                }
                
                if let item = self.queuePlayer.currentItem {
                    self.loop = nil
                    self.loop = .init(
                        player: self.queuePlayer,
                        templateItem: item
                    )
                }
            default:
                self.reset()
            }
        }
        
        self.observerList.append(observer)
    }
    
    func play() {
        guard let item = self.queuePlayer.items().first else {
            return
        }
        if item.asset.isPlayable {
            self.queuePlayer.play()
        }
        self.isPlayAfterLoad = !item.asset.isPlayable
    }
    
    func pause() {
        self.isPlayAfterLoad = false
        self.queuePlayer.pause()
    }
}

extension PicklePlayerView: MakeLayout {
    func addSubViews() {
        self.addSubview(self.thumnailImageView)
        self.layer.addSublayer(self.playerLayer)
    }
    
    func makeConstraints() {
        self.thumnailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.thumnailImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.thumnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.thumnailImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.thumnailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension PicklePlayerView: PickleConfigure {
    func configure(item: PickleItem) {
        guard let url = item.url else {
            return
        }
        
        self.queuePlayer.isMuted = item.isMuted
        self.insertItem(asset: AVAsset(url: url))
        
        if let item = self.queuePlayer.currentItem {
            self.addObserve(item: item)
        }
    }
    
    func configure(event: PickleEvent) {
        switch event {
        case _ as PicklePlayEvent:
            self.play()
        case _ as PicklePauseEvent:
            self.pause()
        default:
            break
        }
    }
}
