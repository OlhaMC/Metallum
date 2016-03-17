//
//  Bands.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class Band {
    
    var name = ""
    var shortDescription = ""
    var formationYear = 0
    var members = [Member]()
    var genres = [String]()
    var albums = [Album]()
    var albumsIds = ""
    
    init?(jsonDictionary: [String : AnyObject]?) {
        if let jsonDictionary = jsonDictionary {
            let bandName = jsonDictionary["name"] as? String
            let foundationYear = jsonDictionary["formationYear"] as? Int
            let shortInfo = jsonDictionary["shortDescription"] as? String
            let genreString = jsonDictionary["genres"] as? String
            let genreArray = genreString?.componentsSeparatedByString(", ")
            
            let people = jsonDictionary["members"] as? [[String : AnyObject]]
            if let people = people {
                for person in people {
                    let member = Member(jsonDictionary: person)
                    if let member = member {
                      members.append(member)
                    }
                }
            }
            
            if let bandName = bandName {
                name = bandName
            } else {
                return nil
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

extension Band: CustomStringConvertible {
    
    var description: String {
        var membersString = ""
        for member in members {
            membersString += "\(member.nickName), "
        }
        let genreString = genres.reduce("", combine: {$0 + "\($1), "})
        let infoString = "\nBand name: \(name) \nYear of foundation: \(formationYear) \nGenres: \(genreString ?? "N/A") \nMembers: \(membersString)"
        return infoString
    }
}
