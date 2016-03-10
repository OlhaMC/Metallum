//
//  Bands.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class Band {
    let name: String?
    var shortDescription: String?
    let formationYear: NSNumber?
    var members: [Member]
    var genres: [String]?
    
    init?(bandName: String?, shortInfo: String?, foundationYear: NSNumber?, membersOfBand: [Member], genres: [String]?) {
        name = bandName
        shortDescription = shortInfo
        formationYear = foundationYear
        members = membersOfBand
        self.genres = genres
        
        if bandName == nil {
            print("Band initialization failed")
            return nil
        }
    }
    
    func showBandInfo() {
        var membersString = ""
        for member in members {
            membersString += "\(member.nickName), "
        }
        let genreString = genres?.reduce("", combine: {$0! + "\($1), "})
        if let name = self.name, year = self.formationYear {
            print("\nBand name: \(name) \nYear of foudation: \(year) \nGenres: \(genreString ?? "N/A") \nMembers: \(membersString)")
        }
    }
    
}

