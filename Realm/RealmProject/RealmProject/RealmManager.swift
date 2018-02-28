//
//  RealmManager.swift
//  RealmProject
//
//  Created by Jackylcs on 28/02/2018.
//  Copyright © 2018 Jacky. All rights reserved.
//

import RealmSwift

class RealmManager {
    let realm = try! Realm()
    
    func deleteDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func saveObjects(objs: [Object]) {
        try! realm.write {
            // If update = true, objects that are already in the Realm will be updated instead of added a new.
            realm.add(objs, update: true)
        }
    }
    
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm.objects(type)
    }
}
