//
//  Member.swift
//  Metallum
//
//  Created by AppleTree on 3/4/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

class Member {
    let firstName: String?
    let lastName: String?
    let nickName: String
    let birthDate: NSDate
    let instruments: [String]?
    
    init (name: String?, lastName: String?, nick: String, birthday: NSDate, bandInstruments: [String]?) {
        firstName = name
        self.lastName = lastName
        nickName = nick
        birthDate = birthday
        instruments = bandInstruments
    }
}