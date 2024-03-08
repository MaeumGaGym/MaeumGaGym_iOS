import Foundation
import Mango
import RxSwift
import RxCocoa
import RxRelay
import RxTest
import RxBlocking

/// Rx로 만들어진 이벤트 스트림을 테스트하는 테스트케이스
open class RxTestCase<T>: BaseTestCase {
    open var scheduler: TestScheduler!
    open var disposeBag: DisposeBag!
    private var resultObserver: TestableObserver<T>!

    /// 이 TestCase에서 관측하고자 하는 대상을 설정합니다.
    open var eventsToObserve: Observable<T> = .empty() {
        didSet {
            disposeBag = DisposeBag()
            scheduler = TestScheduler(initialClock: 0)
            resultObserver = scheduler.createObserver(T.self)
            eventsToObserve.bind(to: resultObserver).disposed(by: disposeBag)
        }
    }

    open func when(observing events: Observable<T>, _ task: () -> Void) {
        self.eventsToObserve = events
        task()
        executeEvents()
    }

    // 이 테스트에서 처리해야 할 입력을 편하게 생성하도록 합니다.
    open func createEvents<U>(_ events: [Recorded<Event<U>>], to relay: PublishRelay<U>) {
        scheduler.createHotObservable(events)
            .bind(to: relay)
            .disposed(by: disposeBag)
    }

    open func createEvents<U>(_ events: [Recorded<Event<U>>], to subject: PublishSubject<U>) {
        scheduler.createHotObservable(events)
            .bind(to: subject)
            .disposed(by: disposeBag)
    }

    open func executeEvents(advanceTo futureTime: VirtualTimeScheduler<TestSchedulerVirtualTimeConverter>.VirtualTime = 10) {
        scheduler.start()
        scheduler.advanceTo(futureTime)
        scheduler.stop()
    }

    /// 테스트의 결과. 테스트의 마지막에는 , 이 값에 기대한 값이 들어있는지 확인한다.
    open var resultEvents: [Recorded<Event<T>>] {
        resultObserver.events
    }
}
