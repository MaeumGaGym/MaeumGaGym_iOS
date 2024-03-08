import UIKit

import Then
import SnapKit
import MGNetworks

final public class AlbumCell: UICollectionViewCell {
    static public let id = SelfCareResourcesService.identifier.albumCell

    private let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        prepare(image: nil)
    }

    public func prepare(image: UIImage?) {
        imageView.image = image
    }
}

private extension AlbumCell {
    func layout() {
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left)
            $0.right.equalTo(contentView.snp.right)
            $0.top.equalTo(contentView.snp.top)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
