//
//  Bands.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class Band: CustomStringConvertible {
    var name = ""
    var shortDescription = ""
    var formationYear = 0
    var members = [Member]()
    var genres = [String]()
    var description: String {
        var membersString = ""
        for member in members {
            membersString += "\(member.nickName), "
        }
        let genreString = genres.reduce("", combine: {$0 + "\($1), "})
        let infoString = "\nBand name: \(name) \nYear of foudation: \(formationYear) \nGenres: \(genreString ?? "N/A") \nMembers: \(membersString)"
        return infoString
    }
    
     init?(jsonDictionary: [String : AnyObject]?) {
        if let jsonDictionary = jsonDictionary {
            let bandName = jsonDictionary["name"] as? String
            let foundationYear = jsonDictionary["formationYear"] as? Int
            let shortInfo = jsonDictionary["shortDescription"] as? String
            let genreString = jsonDictionary["genres"] as? String
            let genreArray = genreString?.componentsSeparatedByString(", ")
            
            let people = jsonDictionary["members"] as? [[String : AnyObject]]
            var bandMembers = [Member]()
            if let people = people {
                for person in people {
                    let firstName = person["firstName"] as? String
                    let lastName = person["lastName"] as? String
                    let nickname = person["nickname"] as? String
                    
                    var birthDate = NSDate()
                    let dateNumber = person["birthDate"] as? NSNumber
                    if let dateNumber = dateNumber {
                        birthDate = NSDate(timeIntervalSince1970: Double(dateNumber)/1000.0)
                    }
                    
                    let instrumentsString = person["instruments"] as? String
                    let instrumentsArray = instrumentsString?.componentsSeparatedByString(", ")
                    
                    if let nickname = nickname {
                        let member = Member(name: firstName, lastName: lastName, nick: nickname, birthday: birthDate, bandInstruments: instrumentsArray)
                        bandMembers.append(member)
                    }
                }
            }
            
            members = bandMembers
            if let bandName = bandName {
                name = bandName
            }
            if let shortInfo = shortInfo {
                shortDescription = shortInfo
            }
            if let foundationYear = foundationYear {
                formationYear = foundationYear
            }
            if let genreArray = genreArray {
                genres = genreArray
            }
        } else {
            return nil
        }
    }
    
}

