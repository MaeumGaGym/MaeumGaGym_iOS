import UIKit
import RxSwift
import RxCocoa
import RxFlow

open class BaseViewModel {
    public var disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    
    public init() {
      }
}
