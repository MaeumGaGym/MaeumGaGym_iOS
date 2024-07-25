import UIKit

import RxFlow
import RxCocoa
import RxSwift

import SnapKit
import Then

import Core
import DSKit
import Domain

import MGLogger

import PostureFeatureInterface

public class PostureDetailViewController: BaseViewController<PostureDetailViewModel> {

    public var id: Int = 1
    
    private var naviBar = PostureDetailNavigationBar()

    private var postureDetailTableView = UITableView().then {
        $0.register(PostureDetailVideoTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailVideoTableViewCell.identifier)
        $0.register(PostureDetailTitleTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTitleTableViewCell.identifier)
        $0.register(PostureDetailTagTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTagTableViewCell.identifier)
        
        $0.register(PostureDetailTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTableViewCell.identifier)
        $0.register(PostureDetailTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTableViewCell.identifier)
        $0.register(PostureDetailTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTableViewCell.identifier)
        $0.register(PostureDetailTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTableViewCell.identifier)
        $0.register(PostureDetailTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailTableViewCell.identifier)
    
        $0.register(PostureDetailPickeTableViewCell.self,
                    forCellReuseIdentifier: PostureDetailPickeTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    private var postureDetailModel: PostureDetailModel = PostureDetailModel(needMachine: Bool(), category: [], simpleName: "", exactName: "", thumbnail: "", video: "", simplePart: [], exactPart: [], startPose: [], exerciseWay: [], breatheWay: [], caution: [], pickleImage: [])
    
    public override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.isNavigationBarHidden = true
        self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0))
    }

    public override func attribute() {
        super.attribute()

        postureDetailTableView.dataSource = self
        postureDetailTableView.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }

    public override func layout() {
        super.layout()

        view.addSubviews([naviBar, postureDetailTableView])
        
        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        postureDetailTableView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    public override func bindViewModel() {
        super.bindViewModel()

        let input = PostureDetailViewModel.Input(
            getDetailData: Observable.just((id)).asDriver(onErrorDriveWith: .never())
        )

        _ = viewModel.transform(input, action: { optput in
            optput.detailData
                .subscribe(onNext: { detailData in
                    MGLogger.debug("detailData: \(detailData)")
                    self.postureDetailModel = detailData
                    self.postureDetailTableView.reloadData()
                }).disposed(by: disposeBag)
            }
        )
        
        naviBar.leftButtonTap
            .subscribe(onNext: {
                PostureStepper.shared.steps.accept(MGStep.postureBack)
            }).disposed(by: disposeBag)
    }
    
    func calculateCategoryCellHeight(muscleGroups: [String]) -> CGFloat {
        let combinedString = muscleGroups.joined(separator: ", ")
        
        let result = [combinedString]
        return calculateCellHeight(text: result)
    }
    
    func formatTexts(_ texts: [String]) -> [String] {
        return texts.map { text -> String in
            guard text.count > 24 else { return text }
            
            return stride(from: 0, to: text.count, by: 24).map { startIndex in
                let endIndex = text.index(text.startIndex, offsetBy: startIndex + 24, limitedBy: text.endIndex) ?? text.endIndex
                let range = text.index(text.startIndex, offsetBy: startIndex)..<endIndex
                var subString = String(text[range])
                
                if subString.hasPrefix(" ") {
                    subString.removeFirst()
                }
                
                return subString
            }.joined(separator: "\n")
        }
    }

    
    private func calculateCellHeight(text: [String]) -> CGFloat {
        let text = formatTexts(text)
        var lineCount = 0
        var modelCount = text.count
        var middleDistance = 12

        for data in text {
            lineCount += data.components(separatedBy: "\n").count - 1
        }

        if modelCount == 1 {
            modelCount = 0
            lineCount += 1
        } else {
            middleDistance = 8
        }

        return CGFloat(80 + (modelCount * 48) + (lineCount * 20) + middleDistance)
    }
    
    
}

extension PostureDetailViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 120
        case 2:
            return 60
        case 3:
            return calculateCategoryCellHeight(muscleGroups: postureDetailModel.exactPart)
        case 4:
            return calculateCellHeight(text: postureDetailModel.startPose)
        case 5:
            return calculateCellHeight(text: postureDetailModel.exerciseWay)
        case 6:
            return calculateCellHeight(text: postureDetailModel.breatheWay)
        case 7:
            return calculateCellHeight(text: postureDetailModel.caution)
        default:
            return 0
        }
    }
}

extension PostureDetailViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 8
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailVideoTableViewCell.identifier,
                for: indexPath) as? PostureDetailVideoTableViewCell
            let model = postureDetailModel.video
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 1:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTitleTableViewCell.identifier,
                for: indexPath) as? PostureDetailTitleTableViewCell
            let model = [postureDetailModel.simpleName, postureDetailModel.exactName]
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 2:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTagTableViewCell.identifier,
                for: indexPath) as? PostureDetailTagTableViewCell
            let model = postureDetailModel.category
            cell?.setup(with: model)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 3:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTableViewCell.identifier,
                for: indexPath) as? PostureDetailTableViewCell
            let model = formatTexts([postureDetailModel.exactPart.joined(separator: ", ")])
            cell?.setup(with: model, titleText: "자극 부위")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 4:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTableViewCell.identifier,
                for: indexPath) as? PostureDetailTableViewCell
            let model = formatTexts(postureDetailModel.startPose)
            cell?.setup(with: model, titleText: "시작 자세")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 5:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTableViewCell.identifier,
                for: indexPath) as? PostureDetailTableViewCell
            let model = formatTexts(postureDetailModel.exerciseWay)
            cell?.setup(with: model, titleText: "운동 방법")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 6:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTableViewCell.identifier,
                for: indexPath) as? PostureDetailTableViewCell
            let model = formatTexts(postureDetailModel.breatheWay)
            cell?.setup(with: model, titleText: "호흡법")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 7:
            let cell = postureDetailTableView.dequeueReusableCell(
                withIdentifier: PostureDetailTableViewCell.identifier,
                for: indexPath) as? PostureDetailTableViewCell
            let model = formatTexts(postureDetailModel.caution)
            cell?.setup(with: model, titleText: "주의 사항")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension PostureDetailViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
