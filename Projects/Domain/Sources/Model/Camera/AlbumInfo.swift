import Photos
import UIKit

public struct AlbumInfo: Identifiable {
    public let id: String?
    public let name: String
    public let count: Int
    public let album: PHFetchResult<PHAsset>
    
    public init(id: String?, name: String, count: Int, album: PHFetchResult<PHAsset>) {
        self.id = id
        self.name = name
        self.count = count
        self.album = album
    }
}
