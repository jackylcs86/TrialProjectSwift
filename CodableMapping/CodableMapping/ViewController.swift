//
//  ViewController.swift
//  CodableMapping
//
//  Created by Jacky Liew on 10/03/2020.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "/mock/Foo/foo", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        let myFoo = try! JSONDecoder().decode(Foo.self, from: data)
        // Initializes a Foo object from the JSON data at the top.
        print("My Foo :: \(myFoo), BestFriend :: \(myFoo.bestFriend)")
        
        let dataToSend = try! JSONEncoder().encode(myFoo)
        // Turns your Foo object into raw JSON data you can send back!
        print("Data To Send :: \(dataToSend)")
        
        let dataToSendCheck = try! JSONDecoder().decode(Foo.self, from: dataToSend)
        print("Data To Send Check :: \(dataToSendCheck)")
        
    }


}

