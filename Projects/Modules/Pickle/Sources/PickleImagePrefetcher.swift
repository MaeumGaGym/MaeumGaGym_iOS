import UIKit
import AVFoundation

final class PickleImagePrefetcher: PicklePrefetcher {
    
    var prefetchURLs: [URL] = []
    var completedItems: [Response] = []
    var failedErrors: [Error] = []
    var isTasking: Bool = false
    var queue: DispatchQueue = .init(label: "video.pickle.prefetch")
    var pendingQueue: PriorityQueue<PendingItem> = {
        let queue = PriorityQueue<PendingItem> { (lhs: PendingItem, rhs: PendingItem) -> Bool in
            return lhs > rhs
        }
        return queue
    }()
    var priorityCount = 1
    private var asset: AVAsset?
    
    func load(url: URL, completion: @escaping (Response) -> Void) {
        guard PickleCacheProvider.shared.getImage(url: url) == nil else {
            completion(.fail(FetchError.image))
            return
        }
        
        self.asset = AVAsset(url: url)
        self.asset?.generateThumbnail { [weak self] (image: UIImage?) in
            self?.asset = nil
            if let image = image {
                PickleCacheProvider.shared.saveImage(url: url, image: image)
                completion(.success)
                return
            }
            completion(.fail(FetchError.image))
        }
    }
}

private extension AVAsset {
    func generateThumbnail(completion: @escaping (UIImage?) -> Void) { // 썸내일 뽑아오는 코드
        let imageGenerator = AVAssetImageGenerator(asset: self)
        let time = CMTime(seconds: 0.0, preferredTimescale: 600)
        let times = [NSValue(time: time)]
        imageGenerator.appliesPreferredTrackTransform = true
        imageGenerator.generateCGImagesAsynchronously(
            forTimes: times,
            completionHandler: { (_, image, _, _, _) in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            }
        )
    }
}
