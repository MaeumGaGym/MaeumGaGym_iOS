import UIKit

public final class PickleCacheProvider {
    
    private var imageCaches: [String: UIImage] = [:]
    static let shared = PickleCacheProvider()
    
    public func saveImage(url: URL, image: UIImage) {
        self.imageCaches[url.absoluteString] = image
    }
    
    public func getImage(url: URL?) -> UIImage? {
        guard let url = url,
              self.imageCaches.keys.contains(url.absoluteString) else {
            return nil
        }
        
        return self.imageCaches[url.absoluteString]
    }
    
    deinit {
        print("deinit: VideoReelsCacheProvider")
    }
}
