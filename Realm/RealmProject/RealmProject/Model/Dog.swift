//
//  Dog.swift
//  RealmProject
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var picture: Data? = nil // optionals supported
    let dogs = List<Dog>()
}
