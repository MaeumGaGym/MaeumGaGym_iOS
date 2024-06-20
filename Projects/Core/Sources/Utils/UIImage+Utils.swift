import UIKit

public extension UIImage {
    func resized(toWidth width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

public extension UIImageView {
  func imageFrom(url:URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data:data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
