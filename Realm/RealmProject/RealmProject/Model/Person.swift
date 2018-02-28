//
//  Person.swift
//  RealmProject
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {
    @objc private(set) dynamic var id = 0
    @objc private(set) dynamic var name = ""
    @objc private(set) dynamic var email = ""
    
    /**
     Override Object.primaryKey() to set the model’s primary key. Declaring a primary key allows objects to be looked up and updated efficiently and enforces uniqueness for each value.
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, name: String, email: String) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
    }
}
