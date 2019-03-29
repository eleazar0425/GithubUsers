//
//  ViewController.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Mapper

class GithubUsersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchController: UISearchController!
    
    var githubUsers = [GithubUser]()
    
    var disposeBag = DisposeBag()
    
    var viewModel: GithubUsersViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.largeTitleDisplayMode = .always
        //self.searchController =  UISearchController(searchResultsController: nil)
        //self.searchController.searchBar.delegate = self
        //self.navigationItem.searchController = searchController
        //self.navigationItem.hidesSearchBarWhenScrolling = false
        
        
        viewModel = GithubUsersViewModel()
        
        viewModel.users.bind(to: self.collectionView.rx.items(cellIdentifier: "githubUserViewCell", cellType: GithubUserViewCell.self)) { row, user, cell in
                cell.bind(user: user)
            }.disposed(by: disposeBag)
        
        self.collectionView.rx
            .contentOffset
            .flatMap { [unowned self] _ in
                return Observable.just(self.collectionView.isNearTheBottomEdge())
        }.distinctUntilChanged()
        .bind(to: viewModel.loadMore)
        .disposed(by: disposeBag)
    }
}
