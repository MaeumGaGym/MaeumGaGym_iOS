import UIKit

open class BaseDesignSystemTableViewController<T: RawRepresentable & CaseIterable>: 
    UITableViewController where T.RawValue == String {

    var designSystems: [T] = T.allCases as! [T]

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeContentTitle = "MaeumGaGym design System"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.backgroundColor = .white
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return designSystems.count
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
        self.showDetailViewController(for: designSystem)
    }

    public func showDetailViewController(for designSystem: T) {
        fatalError("Subclasses must override this method.")
    }
}
