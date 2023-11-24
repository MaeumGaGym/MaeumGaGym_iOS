import UIKit
import Core

open class PickleCollectionViewCell: UICollectionViewCell, MakeLayout, PickleConfigure {
    
    private let playerView: PicklePlayerView = {
        let playerView = PicklePlayerView()
        return playerView
    }()
    
    open var didMakeConstraints: Bool = false
    
    init() {
        defer {
            self.makeLayout()
        }
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        defer {
            self.makeLayout()
        }
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.playerView.reset()
    }
    
    func setThumnailImage(image: UIImage) {
        self.playerView.thumnailImageView.image = image
    }
    
    open func addSubViews() {
        self.contentView.addSubview(self.playerView)
    }
    
    open func makeConstraints() {
        self.playerView.translatesAutoresizingMaskIntoConstraints = false
        self.playerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.playerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.playerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.playerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    open func configure(item: PickleItem) {
        self.playerView.configure(item: item)
    }
    
    open func configure(event: PickleEvent) {
        self.playerView.configure(event: event)
    }
}
