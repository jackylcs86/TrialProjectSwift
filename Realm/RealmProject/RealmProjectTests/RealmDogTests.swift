//
//  RealmDogTests.swift
//  RealmProjectTests
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import XCTest
@testable import RealmProject

class RealmDogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDog() {
        
        let dog = Dog()
        dog.name = "Rex"
        dog.age = 1
        print("My dog \(dog.name) is \(dog.age) years old.")
//        https://realm.io/docs/swift/latest To Be Continue
    }

    
}
