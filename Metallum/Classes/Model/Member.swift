//
//  Member.swift
//  Metallum
//
//  Created by AppleTree on 3/4/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class Member {
    
    var firstName = ""
    var lastName = ""
    var nickName = ""
    var birthDate = NSDate()
    var instruments = [String]()
    
    init?(jsonDictionary: [String : AnyObject]?) {
        if let jsonDictionary = jsonDictionary {
            let firstName = jsonDictionary["firstName"] as? String
            let lastName = jsonDictionary["lastName"] as? String
            let nickname = jsonDictionary["nickname"] as? String
            
            let instrumentsString = jsonDictionary["instruments"] as? String
            let instrumentsArray = instrumentsString?.componentsSeparatedByString(", ")
            
            let dateNumber = jsonDictionary["birthDate"] as? NSNumber
            if let dateNumber = dateNumber {
                birthDate = NSDate(timeIntervalSince1970: Double(dateNumber)/1000.0)
            }
            
            if let firstName = firstName {
                self.firstName = firstName
            }
            if let lastName = lastName {
                self.lastName = lastName
            }
            if let nickname = nickname {
                nickName = nickname
            } else {
                return nil
            }
            if let instrumentsArray = instrumentsArray {
                instruments = instrumentsArray
            }
        } else {
            return nil
        }
    }
}

extension Member: CustomStringConvertible {
    
    var description: String {
        let instrumentsString = instruments.reduce("", combine: {$0 + "\($1), "})
        return "\nName: \(firstName) \nLastName: \(lastName) \nNick: \(nickName) \nInstrument: \(instrumentsString ?? "N/A") \nBirthday: \(birthDate)"
    }
}