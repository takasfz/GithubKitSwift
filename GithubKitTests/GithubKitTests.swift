//
//  GithubKitTests.swift
//  GithubKitTests
//
//  Created by Takashi Kinjo on 23/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import XCTest
@testable import GithubKit

import RxSwift
import RxTest
import RxBlocking

class GithubKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ApiSession.shared.token = "Your Github Personal Access Token"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_search() {
        let request = SearchUserRequest(query: "marty", after: nil, limit: 5)
        let observable = ApiSession.shared.rx.send(request)
        let result = try! observable.toBlocking().single()
        
        print("\(result)")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
