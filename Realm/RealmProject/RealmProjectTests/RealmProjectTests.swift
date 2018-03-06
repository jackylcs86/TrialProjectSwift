//
//  RealmProjectTests.swift
//  RealmProjectTests
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import XCTest
@testable import RealmProject

class RealmProjectTests: XCTestCase {
    
    let realm = RealmManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAll() {
        let persons = addTestPerson()
        realm.saveObjects(objs: persons)
        getObjects()
    }
    
    func addTestPerson() -> [Person] {
        var persons = [Person]()
        for index in 0...9 {
            let newPerson = Person(id: index, name: "Name\(index)", email: "Name\(index).gmail.com")
            persons.append(newPerson)
        }
        return persons
    }
    
    func getObjects() {
        if let objects = realm.getObjects(type: Person.self) {
            for element in objects {
                if let person = element as? Person {
                    print("\(person.name), \(person.id), \(person.email)")
                }
            }
        }
    }
    
    
}
