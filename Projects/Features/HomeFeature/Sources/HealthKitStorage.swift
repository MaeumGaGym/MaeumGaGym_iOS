import HealthKit

final public class HealthKitStorage {
    static public let shared = HealthKitStorage()

    private let store = HKHealthStore()

    private let typesToShare: Set<HKSampleType> = [
        HKObjectType.quantityType(forIdentifier: .stepCount)!
    ]

    private var concurrecy: Concurrency?

    private init() {
        self.concurrecy = Concurrency(store, toShare: typesToShare)
    }

    public func requestAuthorizationIfNeeded() async throws -> Bool {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("아이폰 외 다른 기기에서는 사용할 수 없습니다.")
            return false
        }

        guard let concurrecy = concurrecy else {
            fatalError("Concurrency is not supported.")
        }

        return try await concurrecy.requestAuthorization()
    }

    public func retrieveStepCount(withStart start: Date?,
                                  end: Date?,
                                  options: HKQueryOptions) async throws -> (HKSampleQuery,
                                                                            [HKSample]?)  {
        let predicate = HKQuery.predicateForSamples(withStart: start,
                                                    end: end,
                                                    options: options)
        guard let concurrecy = concurrecy else {
            fatalError("Concurrency is not supported.")
        }

        return try await concurrecy.retrieveStepCount(predicate: predicate)
    }
}

// MARK: - HealthKitStorage.Concurrency
public extension HealthKitStorage {

    final class Concurrency {
        private let store: HKHealthStore
        private let typesToShare: Set<HKSampleType>

        init(_ store: HKHealthStore, toShare typesToShare: Set<HKSampleType>) {
            self.store = store
            self.typesToShare = typesToShare
        }

        func requestAuthorization() async throws -> Bool {
            return try await withCheckedThrowingContinuation { continuation in
                store.requestAuthorization(toShare: typesToShare, read: typesToShare) { isSuccess, error in
                    if let error = error {
                        continuation.resume(with: .failure(error))
                    } else {
                        continuation.resume(with: .success(isSuccess))
                    }
                }
            }
        }

        func retrieveStepCount(predicate: NSPredicate) async throws -> (HKSampleQuery, [HKSample]?) {
            return try await withCheckedThrowingContinuation { continuation in
                guard let stepType = HKSampleType.quantityType(forIdentifier: .stepCount) else {
                    let error = NSError(domain: "Invalid a HKQuantityType", code: 500, userInfo: nil)
                    continuation.resume(throwing: error)
                    return
                }

                let query = HKSampleQuery(sampleType: stepType,
                                          predicate: predicate,
                                          limit: 0,
                                          sortDescriptors: nil) { query, sample, error in
                    continuation.resume(with: .success((query, sample)))
                }

                store.execute(query)
            }
        }
    }
}
