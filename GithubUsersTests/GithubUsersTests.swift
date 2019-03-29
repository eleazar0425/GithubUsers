//
//  GithubUsersTests.swift
//  GithubUsersTests
//
//  Created by Eleazar Estrella GB on 3/28/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import XCTest
import Mapper
import RxSwift
@testable import GithubUsers


class GithubUsersTests: XCTestCase {
    
    var user: GithubUser!
    var service: GithubService!
    var disposeBag: DisposeBag!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        user = try! GithubUser(map: Mapper(JSON: ["login": "eleazar0425", "avatar_url": "https://avatars0.githubusercontent.com/u/15700438?v=4", "id": 64907117]))
    
        service = GithubService()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        user = nil
        service = nil
        disposeBag = nil
    }

    func testGithubUser(){
        XCTAssertNotNil(user)
        XCTAssertFalse(user.avatarUrl.isEmpty)
        XCTAssertFalse(user.username.isEmpty)
    }
    
    
    func testService(){
        let expectation = self.expectation(description: "Wait for the  githubusers request to finish")
        
        service.getUsers(since: 0)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { users in
                XCTAssert(users.count == 30)
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        let expectation2 = self.expectation(description: "Wait for the githubuser repositories request to finish")
        
        service.findUserRepositories(username: "eleazar0425")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { respositories in
                expectation2.fulfill()
            }, onError: { error in
                XCTFail()
            }).disposed(by: disposeBag)
        
        let _ = XCTWaiter.wait(for: [expectation, expectation2], timeout: 50)
    }
}
