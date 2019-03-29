//
//  GithubUserDetailViewController.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit
import AlamofireImage
import RxSwift
import RxCocoa

class GithubUserDetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var githubUser: GithubUser!
    var viewModel: GithubUserDetailViewModelType!
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let githubUser = githubUser else {
            fatalError("In order to use this viewController, githubUser property must be defined")
        }
        
        self.viewModel = GithubUserDetailViewModel(gihubUser: self.githubUser)
        
        viewModel.repositories.bind(to: tableView.rx.items(cellIdentifier: "repositoryTableViewCell", cellType: RepositoryTableViewCell.self)) { row, repo, cell in
            cell.bind(repository: repo)
        }.disposed(by: disposeBag)
        
        self.avatarImage.af_setImage(withURL: URL(string: githubUser.avatarUrl)!)
        self.usernameLabel.text = githubUser.username
    }
}
