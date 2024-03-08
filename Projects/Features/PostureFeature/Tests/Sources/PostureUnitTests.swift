import Mango
import TestCore
import SnapshotTesting
import UIKit
import XCTest
import PostureFeature
import Domain
import Data
import MGNetworks
import Core
import RxTest

final class PostureUnitTests: RxTestCase<String> {
    var postureService: PostureService!
    var postureRepository: PostureRepository!
    var useCase: PostureUseCase!
    var viewModel: PostureMainViewModel!
    var viewController: PostureMainViewController!

    func test_홈_화면_구조_보기() {
        // Given
        postureService = PostureService()
        postureRepository = PostureRepository(networkService: postureService)
        useCase = DefaultPostureUseCase(repository: postureRepository)
        viewModel = PostureMainViewModel(useCase: useCase)
        let viewController = PostureMainViewController(viewModel)

        // when
        viewController.loadViewIfNeeded()

        // Then
        let axSnapshot = viewController.axMangoshot()
        print(axSnapshot)
    }

    func test_자세_사진_스크린샷_저장() {
        postureService = PostureService()
        postureRepository = PostureRepository(networkService: postureService)
        useCase = DefaultPostureUseCase(repository: postureRepository)
        viewModel = PostureMainViewModel(useCase: useCase)
        let viewController = PostureMainViewController(viewModel)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13ProMax))
    }
}
