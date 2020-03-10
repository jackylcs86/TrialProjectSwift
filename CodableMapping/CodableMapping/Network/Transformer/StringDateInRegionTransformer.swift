//
//  StringDateInRegionTransformer.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import CodableExtensions
import SwiftDate

class StringDateInRegionTransformer: CodingContainerTransformer {
    typealias Input = String
    typealias Output = DateInRegion
    
    let inputRegion: Region
    let outputRegion: Region
    let formats: [String]
    
    init(inputRegion: Region, outputRegion: Region, formats: [String]) {
        self.inputRegion = inputRegion
        self.outputRegion = outputRegion
        self.formats = formats
    }
    func transform(_ decoded: Input) throws -> Output {
        if let ret = decoded.toDate(self.formats, region: inputRegion)?.convertTo(region: outputRegion) {
            return ret
        } else {
            print("String DateInRegion Transform Error")
            throw NSError(domain: "MyDomain", code: 500, userInfo: nil)
        }
    }
    func transform(_ encoded: Output) throws -> Input {
        return encoded.convertTo(region: inputRegion).toString(.custom(formats.first!))
    }
}


extension StringDateInRegionTransformer {

    static let gmtRegion: Region = Region(
        calendar: Calendars.gregorian.toCalendar(),
        zone: TimeZone(abbreviation: "GMT+8:00")!,
        locale: Locale(identifier: "en_US_POSIX")
    )

    static let iso8601Strings: [String] = [
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
        "yyyy-MM-dd'T'HH:mm:ss",
        "yyyy-MM-dd'T'HH:mm:ss.SSS",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
    ]
    
    public static let iso8601s = StringDateInRegionTransformer(
        inputRegion: gmtRegion,
        outputRegion: gmtRegion,
        formats: iso8601Strings
    )
    
}
