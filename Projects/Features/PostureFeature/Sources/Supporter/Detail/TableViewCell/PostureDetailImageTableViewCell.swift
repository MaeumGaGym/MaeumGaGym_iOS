import UIKit
import SnapKit
import Then
import Core
import DSKit
import ImageIO

public class PostureDetailVideoTableViewCell: BaseTableViewCell {
    
    static let identifier: String = "PostureDetailVideoTableViewCell"
    
    private var videoContainerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray25.color
    }
    
    private var gifImageView = UIImageView()
    
    public override func layout() {
        super.layout()
        
        contentView.addSubview(videoContainerView)
        
        videoContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        videoContainerView.addSubview(gifImageView)
        gifImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        gifImageView.contentMode = .scaleAspectFit
    }
    
    public func setup(with url: String) {
        guard let gifURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: gifURL), let imageSource = CGImageSourceCreateWithData(data as CFData, nil) {
                var images = [UIImage]()
                var durations = [Double]()
                let count = CGImageSourceGetCount(imageSource)
                for i in 0..<count {
                    if let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) {
                        images.append(UIImage(cgImage: cgImage))
                        
                        // Get frame duration
                        let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? [CFString: Any]
                        let gifInfo = properties?[kCGImagePropertyGIFDictionary] as? [CFString: Any]
                        let frameDuration = gifInfo?[kCGImagePropertyGIFUnclampedDelayTime] as? Double ?? gifInfo?[kCGImagePropertyGIFDelayTime] as? Double ?? 0.1
                        durations.append(frameDuration)
                    }
                }
                
                let totalDuration = durations.reduce(0, +)
                
                DispatchQueue.main.async {
                    self.gifImageView.animationImages = images
                    self.gifImageView.animationDuration = totalDuration
                    self.gifImageView.startAnimating()
                }
            }
        }
    }
}
