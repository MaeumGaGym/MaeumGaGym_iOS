import UIKit
import DSKit

fileprivate enum buttonType: String, CaseIterable {
    case agree
    case auth
    case certification
    case icon
    case check
    case timer
    case toggle
}

public class ButtonTableViewController: UITableViewController  {
    
    private var designSystems: [buttonType] = buttonType.allCases
    
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
        case .agree:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSAgreeButtonVC(), animated: true)
            break
        case .auth:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSAuthButtonVC(), animated: true)
            break
        case .certification:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSCertificationButtonVC(), animated: true)
            break
        case .icon:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSIconButtonVC(), animated: true)
            break
        case .check:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSCheckButtonVC(), animated: true)
            break
        case .timer:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSTimerButtonVC(), animated: true)
            break
        case .toggle:
            print("커스텀 버튼")
            self.navigationController?.pushViewController(DSToggleButtonVC(), animated: true)
            break
        }
    }
}


