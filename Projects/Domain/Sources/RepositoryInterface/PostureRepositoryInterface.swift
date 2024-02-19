import UIKit

import RxSwift

public protocol PostureRepositoryInterface {
    func getRecommandData() -> Single<[PostureRecommandModel]>
}
