import UIKit

import RxSwift
import RxCocoa

import MGLogger
import DSKit
import Core

public class PicklePreparingViewController: PreparingViewController {
    public init() {
        super.init(preparingType: .pickle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
