//
//  GithubUsersViewModel.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubUsersViewModelType {
    var users: Observable<[GithubUser]>! { get }
    var loadMore: BehaviorSubject<Bool>! { get }
}


class GithubUsersViewModel: GithubUsersViewModelType {
    var users: Observable<[GithubUser]>!
    var service: GithubService
    var lastUser = 0
    var loadMore: BehaviorSubject<Bool>!
    
    init(service: GithubService = GithubService()){
        self.service = service
        
        var userArray = [GithubUser]()
        loadMore = BehaviorSubject(value: false)
        
        let requestFirst = service.getUsers(since: 0)
        
        let requestNext = loadMore.flatMapLatest {  loadMore -> Observable<[GithubUser]> in
            guard loadMore, let last = userArray.last else { return .empty() }
            return service.getUsers(since: last.id)
        }
        
        users = Observable.merge(requestFirst, requestNext)
            .map { users -> [GithubUser]  in
                for user in users {
                    userArray.append(user)
                }
                return userArray
            }
    }
}
