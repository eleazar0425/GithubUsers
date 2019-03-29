//
//  GithubService.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import Moya

enum GithubTarget {
    case users(since: Int)
    case findUserRepositories(username: String)
}

extension GithubTarget: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .users(_):
            return "/users"
        case .findUserRepositories(let username):
            return "/users/\(username)/repos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]  {
        switch self {
        case .users(let since):
            return ["since": since]
        default:
            return [:]
        }
    }
    
    var task: Task {
        switch self{
        case .users(_), .findUserRepositories(_):
            return .requestParameters(parameters: self.parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
