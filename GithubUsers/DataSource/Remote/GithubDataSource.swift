//
//  GithubDataSource.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubDataSource {
    func getUsers(since: Int) -> Observable<[GithubUser]>
}
