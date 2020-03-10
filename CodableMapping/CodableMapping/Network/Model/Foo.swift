//
//  Foo.swift
//  CodableMapping
//
//  Created by Jacky Liew on 10/03/2020.
//

import UIKit
import SwiftDate

struct Foo: Codable {
    let bar: Bool
    let baz: String
    let time: DateInRegion
    let bestFriend: String
    let funnyGuy: String
    let favoriteWeirdo: String

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case bar = "Bar"
        case baz = "Baz"
        case time = "Time"
        case friends = "Friends"
        case bestFriend = "Best"
        case funnyGuy = "FunnyGuy"
        case favoriteWeirdo = "FavoriteWeirdo"
    }

    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        bar = try response.decode(Bool.self, forKey: .bar)
        baz = try response.decode(String.self, forKey: .baz)
        time = try response.decode(.time, transformer: StringDateInRegionTransformer.iso8601s)
        
        let friends = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
        bestFriend = try friends.decode(String.self, forKey: .bestFriend)
        funnyGuy = try friends.decode(String.self, forKey: .funnyGuy)
        favoriteWeirdo = try friends.decode(String.self, forKey: .favoriteWeirdo)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        try response.encode(bar, forKey: .bar)
        try response.encode(baz, forKey: .baz)
        try response.encode(time, forKey: .time, transformer: StringDateInRegionTransformer.iso8601s)
        
        var friends = response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
        try friends.encode(bestFriend, forKey: .bestFriend)
        try friends.encode(funnyGuy, forKey: .funnyGuy)
        try friends.encode(favoriteWeirdo, forKey: .favoriteWeirdo)
    }
}
