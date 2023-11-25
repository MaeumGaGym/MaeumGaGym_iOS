import UIKit

public protocol PickleViewDelegate: AnyObject {
    func willDisyplay(cell: UICollectionViewCell, data: PickleItem?, page: Int)
    func didEndDisplaying(cell: UICollectionViewCell, data: PickleItem?, page: Int)
    func currentPage(_ page: Int, data: PickleItem?)
}
