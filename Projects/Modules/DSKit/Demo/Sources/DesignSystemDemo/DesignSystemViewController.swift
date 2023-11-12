import UIKit

fileprivate enum DesignSystemType: String, CaseIterable {
    case button
}

public class DesignSystemViewController: UITableViewController {
    
    private var designSystems: [DesignSystemType] = DesignSystemType.allCases
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeContentTitle = "MaeumGaGym design System"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.backgroundColor = .white
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        designSystems.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.designSystems[indexPath.item].rawValue
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let designSystem = self.designSystems[indexPath.item]
        switch designSystem {
        case .button:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(ButtonViewController(), animated: true)
            break
        }
    }
}
