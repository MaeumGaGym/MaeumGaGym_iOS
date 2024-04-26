//import Photos
//import UIKit
//
//import Domain
//
//public enum MediaType {
//    case all
//    case image
//    case video
//}
//
//final public class PhotoService: NSObject {
//    static public let shared = PhotoService()
//    public weak var delegate: PHPhotoLibraryChangeObserver?
//    
//    override private init() {
//        super.init()
//        PHPhotoLibrary.shared().register(self)
//    }
//    
//    private enum Const {
//        static let titleText: (MediaType?) -> String = { mediaType in
//            switch mediaType {
//            case .all:
//                return "이미지와 동영상"
//            case .image:
//                return "이미지"
//            case .video:
//                return "동영상"
//            default:
//                return "비어있는 타이틀"
//            }
//        }
//        static let predicate: (MediaType) -> NSPredicate = { mediaType in
//            let format = "mediaType == %d"
//            switch mediaType {
//            case .all:
//                return .init(
//                    format: format + " || " + format,
//                    PHAssetMediaType.image.rawValue,
//                    PHAssetMediaType.video.rawValue
//                )
//            case .image:
//                return .init(
//                    format: format,
//                    PHAssetMediaType.image.rawValue
//                )
//            case .video:
//                return .init(
//                    format: format,
//                    PHAssetMediaType.video.rawValue
//                )
//            }
//        }
//        static public let sortDescriptors = [
//            NSSortDescriptor(key: "creationDate", ascending: false),
//            NSSortDescriptor(key: "modificationDate", ascending: false)
//        ]
//    }
//    
//    let imageManager = PHCachingImageManager()
//    
//    deinit {
//        PHPhotoLibrary.shared().unregisterChangeObserver(self)
//    }
//    
//    public func getAlbums(mediaType: MediaType, completion: @escaping ([AlbumInfo]) -> Void) {
//        var allAlbums = [AlbumInfo]()
//        defer {
//            completion(allAlbums)
//        }
//        
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.predicate = Const.predicate(mediaType)
//        let standardAlbum = PHAsset.fetchAssets(with: fetchOptions)
//        allAlbums.append(
//            .init(
//                id: nil,
//                name: Const.titleText(mediaType),
//                count: standardAlbum.count,
//                album: standardAlbum
//            )
//        )
//        
//        let smartAlbums = PHAssetCollection.fetchAssetCollections(
//            with: .smartAlbum,
//            subtype: .any,
//            options: PHFetchOptions()
//        )
//        guard 0 < smartAlbums.count else { return }
//        smartAlbums.enumerateObjects { smartAlbum, index, pointer in
//            guard index <= smartAlbums.count - 1 else {
//                pointer.pointee = true
//                return
//            }
//            if smartAlbum.estimatedAssetCount == NSNotFound {
//                let fetchOptions = PHFetchOptions()
//                fetchOptions.predicate = Const.predicate(mediaType)
//                fetchOptions.sortDescriptors = Const.sortDescriptors
//                let smartAlbums = PHAsset.fetchAssets(in: smartAlbum, options: fetchOptions)
//                allAlbums.append(
//                    .init(
//                        id: smartAlbum.localIdentifier,
//                        name: smartAlbum.localizedTitle ?? Const.titleText(nil),
//                        count: smartAlbums.count,
//                        album: smartAlbums
//                    )
//                )
//            }
//        }
//    }
//    
//    public func getPHAssets(album: PHFetchResult<PHAsset>, completion: @escaping ([PHAsset]) -> Void) {
//        guard 0 < album.count else { return }
//        var phAssets = [PHAsset]()
//        
//        album.enumerateObjects { asset, index, stopPointer in
//            guard index <= album.count - 1 else {
//                stopPointer.pointee = true
//                return
//            }
//            phAssets.append(asset)
//        }
//        
//        completion(phAssets)
//    }
//    
//    public func fetchImage(
//        asset: PHAsset,
//        size: CGSize,
//        contentMode: PHImageContentMode,
//        completion: @escaping (UIImage) -> Void
//    ) {
//        let option = PHImageRequestOptions()
//        option.isNetworkAccessAllowed = true
//        option.deliveryMode = .highQualityFormat
//        
//        self.imageManager.requestImage(
//            for: asset,
//            targetSize: size,
//            contentMode: contentMode,
//            options: option
//        ) { image, _ in
//            guard let image = image else { return }
//            completion(image)
//        }
//    }
//}
//
//extension PhotoService: PHPhotoLibraryChangeObserver {
//    public func photoLibraryDidChange(_ changeInstance: PHChange) {
//        self.delegate?.photoLibraryDidChange(changeInstance)
//    }
//}
