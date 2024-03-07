import Mango
import TestCore
import SnapshotTesting
import UIKit
import XCTest
import HomeFeature
import Domain
import Data
import MGNetworks

final class HomeUnitTests: RxTestCase<String> {
    var homeService: HomeService!
    var homeRepository: HomeRepository!
    var useCase: DefaultHomeUseCase!
    var viewModel: HomeViewModel!
    var viewController: HomeViewController!

    func test_홈_화면_구조_보기() {
        // Given
        homeService = HomeService()
        homeRepository = HomeRepository(networkService: homeService)
        useCase = DefaultHomeUseCase(repository: homeRepository)
        viewModel = HomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel)

        // when
        viewController.loadViewIfNeeded()

        // Then
        let axSnapshot = viewController.axMangoshot()
        print(axSnapshot)
    }

    func test_홈_사진_스크린샷_저장() {
        homeService = HomeService()
        homeRepository = HomeRepository(networkService: homeService)
        useCase = DefaultHomeUseCase(repository: homeRepository)
        viewModel = HomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13ProMax))
    }
}
