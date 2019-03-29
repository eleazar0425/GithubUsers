//
//  GithubUserDetailViewModel.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubUserDetailViewModelType {
    var repositories: Observable<[Repository]>! { get }
}

class GithubUserDetailViewModel: GithubUserDetailViewModelType {
    var repositories: Observable<[Repository]>!
    var service: GithubService
    
    init(gihubUser: GithubUser, service: GithubService = GithubService()){
        self.service = service
        self.repositories = service.findUserRepositories(username: gihubUser.username)
    }
}
