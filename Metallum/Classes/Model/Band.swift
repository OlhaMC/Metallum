//
//  Bands.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

enum Instruments: String {
    case LeadVocals, BackingVocals, LeadGuitar, RhythmGuitar, BassGuitar, Drums, Keyboards
}

enum Genres: String {
    case BlackMetal, DeathMetal, DoomMetal, TrashMetal
    case IndustrialMetal, SymphonicMetal, BlackenedDeathMetal
}

class Band {
    let name: String?
    var shortDescription: String?
    let formationYear: NSNumber?
    var members: [Member]
    var genres: [String]?
    
    init? (bandName: String?, shortInfo: String?, foundationYear: NSNumber?, membersOfBand: [Member], genres: [String]?) {
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
        if let name = self.name, year = self.formationYear, genre = self.genres {
            print("\nBand name: \(name) \nYear of foudation: \(year) \nGenres: \(genre)")
        }
    }
    
}

