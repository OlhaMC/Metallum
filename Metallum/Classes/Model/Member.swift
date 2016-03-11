//
//  Member.swift
//  Metallum
//
//  Created by AppleTree on 3/4/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class Member: CustomStringConvertible {
    var firstName: String?
    var lastName: String?
    let nickName: String
    let birthDate: NSDate
    var instruments = [String]()
    var description: String {
        let instrumentsString = instruments.reduce("", combine: {$0 + "\($1), "})
        return "\nName: \(firstName) \nLastName: \(lastName) \nNick: \(nickName) \nInstrument: \(instrumentsString ?? "N/A") \nBirthday: \(birthDate)"
    }
    
    init(name: String?, lastName: String?, nick: String, birthday: NSDate, bandInstruments: [String]?) {
        firstName = name
        self.lastName = lastName
        nickName = nick
        birthDate = birthday
        if let bandInstruments = bandInstruments {
            instruments = bandInstruments
        }
    }
}