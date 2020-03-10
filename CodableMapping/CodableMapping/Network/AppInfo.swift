//
//  AppInfo.swift
//  bonuslink-member-ios
//
//  Created by Yee Chuan Lee on 02/08/2019.
//  Copyright © 2020 Fourtitude.asia. All rights reserved.
//

import Foundation

/*
// FIXME: Pending API Spec
extension BLAPI {
    struct AppInfo {}
}

extension BLAPI.AppInfo {
    class Target: BaseTarget<Request, Response> {
        override var path: String { return "setting/appinfo" }
    }
    
    class Request: BaseRequest {
        var version: String?
        var platform: BLAPI.EnumPlatform?
        
        enum CodingKeys: String, CodingKey {
            case version = "version"
            case platform = "platform"
        }
        
        override func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try? container.encode(version, forKey: .version)
          try? container.encode(platform, forKey: .platform)
        }
    }
    
    class Response: BaseResponse {
        var forceUpdate: Bool?
        
        enum CodingKeys: String, CodingKey {
            case forceUpdate = "forceUpdate"
        }
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            forceUpdate = try? values.decodeIfPresent(Bool.self, forKey: .forceUpdate)
            try super.init(from: decoder)
        }
        
        override init() {
            super.init()
        }
    }
}
*/
