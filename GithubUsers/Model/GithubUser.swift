//
//  GithubUser.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import Mapper

struct GithubUser: Mappable {    
    var username: String
    var avatarUrl: String
    var id: Int
    
    init(map: Mapper) throws {
        try username = map.from("login")
        try avatarUrl = map.from("avatar_url")
        try id = map.from("id")
    }
}
