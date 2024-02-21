import UIKit

import RxSwift

public protocol SelfCareRepositoryInterface {
    func getMyRoutineData() -> Single<SelfCareMyRoutineModel>
}
