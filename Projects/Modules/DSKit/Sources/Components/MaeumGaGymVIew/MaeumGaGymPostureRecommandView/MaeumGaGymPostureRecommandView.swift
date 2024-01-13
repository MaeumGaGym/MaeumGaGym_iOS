import UIKit
import SnapKit
import Then

open class MaeumGaGymPostureRecommandView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    var cellData: [(image: UIImage, text1: String, text2: String)] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    public init(cellData: [(image: UIImage, text1: String, text2: String)]) {
        self.cellData = cellData
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.height.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(468.0)
        }
        
        for data in cellData {
                let (imageName, text1, text2) = data
                let cell = CustomCell()
                cell.configure(image: imageName, text1: text1, text2: text2)
                cell.snp.makeConstraints { make in
                    make.width.equalTo(148)
                    make.height.equalTo(200)
                }
                stackView.addArrangedSubview(cell)
            }
                    
        stackView.spacing = 12

        stackView.snp.makeConstraints {
            $0.width.equalTo(486)
        }
    }

}
