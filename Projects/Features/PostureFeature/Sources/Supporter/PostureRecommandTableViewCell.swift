import UIKit
import SnapKit
import Then
import DSKit

class PostureRecommandTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let identifier: String = "PostureRecommandTableViewCell"
    
    var collectionView: UICollectionView!
    var data: [Exercise] = []
    var cellSize: Int = 0

    
    private var titleImageLogo = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = DSKitAsset.Colors.gray50.color
        $0.layer.cornerRadius = 8.0
    }
    
    private var exerciseTitleLabel = UILabel().then {
        $0.font = UIFont.Pretendard.titleMedium
        $0.textColor = .black
        $0.contentMode = .left
    }
    
    private var seemoreButton = MaeumGaGymSeeMoreButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 12
            $0.minimumInteritemSpacing = 12
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(PostureRecommandCollectionViewCell.self, forCellWithReuseIdentifier: PostureRecommandCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .white
        }
        
        addViews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(titleImageLogo)
        contentView.addSubview(exerciseTitleLabel)
        contentView.addSubview(seemoreButton)
        contentView.addSubview(collectionView)

    }
    
    private func setupViews() {
        titleImageLogo.snp.makeConstraints {
            $0.width.height.equalTo(40.0)
            $0.top.equalToSuperview().offset(24.0)
            $0.leading.equalToSuperview().offset(20.0)
        }
        
        exerciseTitleLabel.snp.makeConstraints {
            $0.width.equalTo(89.0)
            $0.height.equalTo(32)
            $0.top.equalTo(titleImageLogo.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(20.0)
        }
        
        seemoreButton.snp.makeConstraints {
            $0.width.equalTo(74.0)
            $0.height.equalTo(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.top.equalToSuperview().offset(28.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().inset(20.0)
            $0.height.equalTo(200.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }
    
    public func selecCell(model: PostureRecommandModel) {
        self.data = model.data
        self.titleImageLogo.image = model.logo
        self.exerciseTitleLabel.text = model.title
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostureRecommandCollectionViewCell.identifier, for: indexPath) as! PostureRecommandCollectionViewCell
        let model = data[indexPath.row]
        cell.setup(exerciseImage: model.image, exerciseNameText: model.name, exercisePartText: model.part)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = data[indexPath.row]
    }
    
    
}

extension PostureRecommandTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 148.0,  height: 200.0)
    }
}
