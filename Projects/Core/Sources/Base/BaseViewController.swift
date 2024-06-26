import UIKit
import RxFlow

import RxSwift
import RxCocoa

import SnapKit

/// BaseViewController는 UIViewController를 제네릭으로 확장하여 다양한 유형의 ViewModel을 지원합니다.
open class BaseViewController<T>: UIViewController {
    /// ViewModel을 저장하는 변수, 제네릭 타입 T를 사용합니다.
    public var viewModel: T
    
    /// RxSwift의 메모리 관리를 위해 사용하는 DisposeBag 인스턴스.
    public var disposeBag = DisposeBag()
    
    /// RxFlow를 사용하여 흐름을 제어하는 PublishRelay.
    public var steps = PublishRelay<Step>()
    
    /// 화면 너비의 비율을 계산하는 프로퍼티.
    public var width: CGFloat {
        return view.frame.width / 430.0
    }
    
    /// 화면 높이의 비율을 계산하는 프로퍼티.
    public var height: CGFloat {
        return view.frame.height / 932.0
    }
    
    /// 기기 화면의 경계를 나타내는 상수.
    let bounds = UIScreen.main.bounds

    /// ViewController의 초기화 함수, ViewModel을 인자로 받습니다.
    public init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    /// Interface Builder를 통해 생성될 때 호출되는 초기화 함수입니다.
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// View의 하위 뷰가 레이아웃될 때 호출됩니다.
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureNavigationBar()
    }

    /// View가 메모리에 로드된 후 호출됩니다.
    open override func viewDidLoad() {
        super.viewDidLoad()
        bindActions()
        bindViewModel()
        layout()
        setupKeyboardHandling()
        attribute()
    }
    
    /// 뷰의 기본 속성을 설정합니다.
    open func attribute() {
        view.backgroundColor = .white
    }

    /// 서브뷰를 구성하고 SnapKit을 사용해서 레이아웃을 구성하는 함수입니다.
    open func layout() { }

    /// ViewModel과의 바인딩을 설정하는 함수입니다.
    open func bindViewModel() { }

    /// 네비게이션 바를 사용자 정의하고 설정하는 함수입니다.
    open func configureNavigationBar() { }
    
    /// 권한 처리를 하는 함수입니다. 예를 들어 카메라 접근 권한 요청 등을 처리합니다.
    open func permissionControlHandling() { }

    /// 키보드 이벤트를 처리하는 함수입니다.
    open func setupKeyboardHandling() { }

    /// 액션 바인딩을 설정하는 함수입니다. RxSwift를 사용하여 UI 이벤트를 처리합니다.
    open func bindActions() { }

    /// 테이블 뷰를 설정하고 초기화하는 함수입니다.
    open func configureTableView() { }

    /// 컬렉션 뷰를 설정하고 초기화하는 함수입니다.
    open func configureCollectionView() { }

    /// 네트워크 요청 등 작업 진행 중 화면에 인디케이터를 표시하는 함수입니다.
    open func showActivityIndicator() { }

    /// 작업 완료 후 화면에서 인디케이터를 숨기는 함수입니다.
    open func hideActivityIndicator() { }

    /// 오류 발생 시 처리를 수행하는 함수입니다.
    open func handleError(_ error: Error) { }

    /// 데이터가 없을 때 빈 상태의 뷰를 보여주는 함수입니다.
    open func showEmptyStateView() { }

    /// 빈 상태 뷰를 숨기는 함수입니다.
    open func hideEmptyStateView() { }
    
    /// 화면을 터치했을 때 키보드를 숨기는 이벤트를 처리합니다.
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
