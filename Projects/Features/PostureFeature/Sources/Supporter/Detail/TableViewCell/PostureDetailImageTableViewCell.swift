import UIKit

import SnapKit
import Then

import Core
import AVKit
import DSKit

public class PostureDetailVideoTableViewCell: BaseTableViewCell {
    
    static let identifier: String = "PostureDetailVideoTableViewCell"
    
    private var videoContainerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
    }
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    public override func layout() {
        super.layout()
        
        contentView.addSubview(videoContainerView)
        
        videoContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func setup(with url: String) {
        
        let dummyURL = URL(string: "https://maeumgagym-bucket.s3.ap-northeast-2.amazonaws.com/%E1%84%85%E1%85%A5%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A1%E1%86%AB+%E1%84%90%E1%85%B3%E1%84%8B%E1%85%B1%E1%84%89%E1%85%B3%E1%84%90%E1%85%B3/06871201-Russian-Twist_waist.hevc.mp4")!
        let videoURL = URL(string: url)
        player?.pause()
        
        player = AVPlayer(url: videoURL ?? dummyURL)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
        
        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspect
        
        if let playerLayer = playerLayer {
            videoContainerView.layer.addSublayer(playerLayer)
            playerLayer.frame = videoContainerView.bounds
        }
        
        player?.play()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = videoContainerView.bounds
    }
}
