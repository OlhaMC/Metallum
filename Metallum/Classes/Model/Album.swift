//
//  Album.swift
//  Metallum
//
//  Created by AppleTree on 3/15/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class Album {
    var title = ""
    var releaseYear = 0
    var objectId = ""
    
    init?(jsonDictionary: [String : AnyObject]?) {
        if let jsonDictionary = jsonDictionary {
            let title = jsonDictionary["name"] as? String
            let releaseYear = jsonDictionary["releaseYear"] as? Int
            let objectId = jsonDictionary["objectId"] as? String
            
            
            if let objectId = objectId {
                self.objectId = objectId
            } else {
                return nil
            }
            if let title = title {
                self.title = title
            }
            if let releaseYear = releaseYear {
                self.releaseYear = releaseYear
            }
        } else {
            return nil
        }
    }
}