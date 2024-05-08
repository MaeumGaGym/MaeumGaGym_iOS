import UIKit
import SnapKit

open class MGDropDown: UIView, UITableViewDataSource, UITableViewDelegate {

    var data = ["남성", "여성"]

    var isDropdownVisible = false {
        didSet {
            arrowImageView.image = isDropdownVisible ? DSKitAsset.Assets.topArrow.image : DSKitAsset.Assets.bottomArrow.image
        }
    }

    let typeLabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = .black
        $0.font = UIFont.Pretendard.bodyMedium
    }
    let dropdownButton = UIButton(type: .system)
    let tableView = UITableView()
    let arrowImageView = UIImageView(image: DSKitAsset.Assets.bottomArrow.image)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSubViews()
        layout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

    func setupUI() {
        setupDropdownButton()
        setupTableView()
        
        self.tableView.isHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
    }
    
    func addSubViews() {
        addSubviews([
            typeLabel,
            dropdownButton,
            tableView
        ])
        dropdownButton.addSubview(arrowImageView)
    }
    func layout() {
        typeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        dropdownButton.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(dropdownButton.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    func setupDropdownButton() {
        dropdownButton.setTitle("성별 선택", for: .normal)
        dropdownButton.setTitleColor(DSKitAsset.Colors.gray200.color, for: .normal)
        dropdownButton.tintColor = UIColor.black
        dropdownButton.titleLabel?.font = UIFont.Pretendard.bodyLarge

        dropdownButton.contentHorizontalAlignment = .leading
        dropdownButton.titleEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 0)

        dropdownButton.backgroundColor = DSKitAsset.Colors.gray25.color
        dropdownButton.layer.cornerRadius = 8.0
        dropdownButton.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        dropdownButton.layer.borderWidth = 1
        
        dropdownButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }

    @objc func toggleDropdown() {
        if isDropdownVisible {
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 0.0
                self.tableView.isHidden = true
            } completion: { _ in
                self.isDropdownVisible.toggle()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.isDropdownVisible.toggle()
                self.tableView.alpha = 1.0
                self.tableView.isHidden = false
            }
        }
    }

}

extension MGDropDown {
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8.0
        tableView.layer.borderColor = DSKitAsset.Colors.gray50.color.cgColor
        tableView.layer.borderWidth = 1
    }

    public func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView:UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell")!
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.font = UIFont.Pretendard.bodyLarge
        cell.backgroundColor = DSKitAsset.Colors.gray25.color
        
        return cell
    }

    public func tableView(_ tableView:UITableView, didSelectRowAt indexPath : IndexPath) {
        print("You selected \(data[indexPath.row])")
        dropDownButtonClick(title: data[indexPath.row])
        toggleDropdown()
    }

    func dropDownButtonClick(title: String) {
        dropdownButton.setTitle(title,for:.normal)
        dropdownButton.setTitleColor(.black, for: .normal)
    }

}
