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
    var repository: Repository!
    var service: GithubService!
    var disposeBag: DisposeBag!
    var githubDataSource: GithubDataSource!
    var viewModel: GithubUsersViewModel!
    var detailViewMdel: GithubUserDetailViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        user = try! GithubUser(map: Mapper(JSON: ["login": "eleazar0425", "avatar_url": "https://avatars0.githubusercontent.com/u/15700438?v=4", "id": 64907117]))
        repository = try! Repository(map: Mapper(JSON: ["id": 64907117, "name": "eleazar0425/Cloud-Index-Calculator-ITLA", "description": NSNull(), "language": "C#", "stargazers_count": 0]))
    
        service = GithubService()
        disposeBag = DisposeBag()
        githubDataSource = MockGithubService(users: [user], repositories: [repository])
        viewModel = GithubUsersViewModel(service: githubDataSource)
        detailViewMdel = GithubUserDetailViewModel(gihubUser: user, service: githubDataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        user = nil
        repository = nil
        service = nil
        githubDataSource = nil
        viewModel = nil
        disposeBag = nil
    }

    func testGithubUser(){
        XCTAssertNotNil(user)
        XCTAssertFalse(user.avatarUrl.isEmpty)
        XCTAssertFalse(user.username.isEmpty)
    }
    
    func testRepository(){
        XCTAssertNotNil(repository)
        XCTAssertFalse(repository.name.isEmpty)
        XCTAssertNotNil(repository.language)
        XCTAssertNil(repository.description)
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
    
    func testViewModel_shouldReturnOneUser(){
        let expectation = self.expectation(description: "Wait for the viewModel response")
        
        viewModel
            .users
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { users in
                XCTAssert(users.count == 1)
                XCTAssert(users[0] == self.user)
                expectation.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            }).disposed(by: disposeBag)
        
        let _ = XCTWaiter.wait(for: [expectation], timeout: 1)
    }
    
    func testViewModel_shouldReturnOneRepository() {
        let expectation = self.expectation(description: "Wait for the viewModel response")
        
        detailViewMdel
            .repositories
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { repositories in
                XCTAssert(repositories.count == 1)
                XCTAssert(repositories[0] == self.repository)
                expectation.fulfill()
            }, onError: { error in
                XCTFail(error.localizedDescription)
            }).disposed(by: disposeBag)
        
        let _ = XCTWaiter.wait(for: [expectation], timeout: 1)
    }
}

class MockGithubService: GithubDataSource {
    
    var users: [GithubUser]
    var repositories: [Repository]
    
    init(users: [GithubUser], repositories: [Repository]){
        self.users = users
        self.repositories = repositories
    }
    
    
    func findUserRepositories(username: String) -> Observable<[Repository]> {
        return Observable.just(repositories)
    }
    
    func getUsers(since: Int) -> Observable<[GithubUser]> {
        return Observable.just(users)
    }
}
