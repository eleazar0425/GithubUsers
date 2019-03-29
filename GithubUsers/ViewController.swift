//
//  ViewController.swift
//  GithubUsers
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxSwift
import Moya_ModelMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let provider = MoyaProvider<GithubTarget>()
        provider.rx.request(.users(since: 0))
            .retry(2)
            .map(to: [GithubUser].self)
            .catchErrorJustReturn([])
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                print(event)
        }
        
        
        let service = GithubService()
        service.getUsers(since: 0)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                print(event)
        }
    }
}

