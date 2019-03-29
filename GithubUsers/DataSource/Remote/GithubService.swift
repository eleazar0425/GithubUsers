//
//  GithubService.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ModelMapper

class GithubService: GithubDataSource {
    
    var provider: MoyaProvider<GithubTarget>
    
    init(provider: MoyaProvider<GithubTarget> = MoyaProvider<GithubTarget>()){
        self.provider = provider
    }
    
    
    func getUsers(since: Int) -> Observable<[GithubUser]> {
        return provider.rx.request(.users(since: since))
            .retry(2)
            .map(to: [GithubUser].self)
            .catchErrorJustReturn([])
            .asObservable()
    }
    
    func findUserRepositories(username: String) -> Observable<[Repository]> {
        return provider.rx.request(.findUserRepositories(username: username))
            .retry(2)
            .map(to: [Repository].self)
            .asObservable()
    }
}
