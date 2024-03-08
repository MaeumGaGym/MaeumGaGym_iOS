import UIKit

import RxSwift
import RxCocoa
import RxFlow

public protocol BaseViewModel: ViewModel {
    
    associatedtype ViewModel: BaseViewModel
        
    associatedtype Input
    associatedtype Output

    func transform(_ input: ViewModel.Input, action: (ViewModel.Output) -> Void) -> ViewModel.Output
}
