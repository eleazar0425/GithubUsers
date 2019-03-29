//
//  Respository.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/29/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import Mapper

struct Repository: Mappable {
    var id: Int
    var name: String
    var description: String?
    var language: String?
    var stargazersCount: Int
    
    init(map: Mapper) throws {
        self.id = try map.from("id")
        self.name = try map.from("name")
        self.description = map.optionalFrom("description")
        self.language = try map.optionalFrom("language")
        self.stargazersCount = try map.from("stargazers_count")
    }
}
