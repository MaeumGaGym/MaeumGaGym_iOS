import UIKit
import SnapKit
import RxSwift
import RxCocoa

open class BaseViewController<T>: UIViewController {
    public let viewModel: T
    public var disposeBag = DisposeBag()
    let bounds = UIScreen.main.bounds

    public init(_ viewModel: T) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bindViewModel()
        configureNavigationBar()
        setupKeyboardHandling()
        attribute()
    }
    
    open func attribute() {
        view.backgroundColor = .white
    }

    open func layout() {
        // 서브뷰를 구성하고 SnapKit을 사용해서 layout을 하는 함수입니다.
    }

    open func bindViewModel() {
        // RxSwift를 사용하여 UI 바인딩을 설정을 하는 함수입니다.
    }

    open func configureNavigationBar() {
        // 내비게이션 바의 모양과 동작을 사용자 지정하고 네비게이션 관련 코드를 설정하는 함수입니다.
    }

    open func setupKeyboardHandling() {
        // 키보드 인벤트처리를 하는 함수입니다.
    }

    open func bindActions() {
        // RxSwift를 사용하여 UI 요소들의 액션과 관련하여 반응형 동작을 설정하는 함수 입니다.
    }

    open func configureTableView() {
        // 테이블 뷰를 설정하고 초기화하기 위한 함수입니다.
    }

    open func configureCollectionView() {
        // 컬렉션 뷰를 설정하고 초기화하기 위한 함수 입니다.
    }

    open func showActivityIndicator() {
        // 네트워크 요청 등 작업 진행 중에 인디케이터를 화면에 표시하는 함수입니다.
    }

    open func hideActivityIndicator() {
        // 작업이 완료되었을 때 인디케이터를 화면에서 숨기는 함수입니다.
    }

    open func handleError(_ error: Error) {
        // 발생한 오류에 대한 처리를 수행하는 함수입니다.
    }

    open func showEmptyStateView() {
        // 데이터가 없을 때 빈 상태를 표시하는 뷰를 보여주는 함수입니다.
    }

    open func hideEmptyStateView() {
        // 빈 상태 뷰를 숨기는 함수이며 데이터가 로드되어서 빈 상태가 아닌 경우 다시 호출됩니다
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
