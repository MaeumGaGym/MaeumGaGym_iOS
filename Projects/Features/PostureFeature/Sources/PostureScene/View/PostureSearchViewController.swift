import UIKit

import SnapKit
import Then

import Core
import PostureFeatureInterface
import DSKit

public class PostureSearchViewController: BaseViewController<PostureSearchViewModel> {
    
    private var searchModel = PostureSearchModel.second
    
    private var searchBarView = MGSearchView(backgroundColor: DSKitAsset.Colors.gray50.color)
    
    private var postureSearchTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        
        $0.register(PostureSearchTableViewCell.self, forCellReuseIdentifier: PostureSearchTableViewCell.identifier)
    }
    
    public override func attribute() {
        super.attribute()

        postureSearchTableView.dataSource = self
        postureSearchTableView.delegate = self
    }
    
    override public func layout() {
        [searchBarView, postureSearchTableView].forEach { view.addSubview($0) }
        
        searchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(40.0)
        }
        
        postureSearchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}

extension PostureSearchViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 96
    }
}

extension PostureSearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchModel.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostureSearchTableViewCell.identifier, for: indexPath) as? PostureSearchTableViewCell
        
        let exercise = searchModel.data[indexPath.row]
        cell?.setup(image: exercise.image, name: exercise.exerciseName, part: exercise.exercisePart)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    
}
