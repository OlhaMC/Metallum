//
//  NetworkManager.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    let session: NSURLSession
    var jsonDictionary: NSDictionary?
    
    private init() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 60.0
        config.HTTPAdditionalHeaders = ["X-Parse-Application-Id" : "G9xrl0w9ZEfthprEWmfpjaLvYoaj4Q9i27GpKr5K",
                                        "X-Parse-REST-API-Key" : "OicKg3pFplcUgJOm8oNVKhdpzK7nv2h5MnR2xkJS",
                                        "Content-Type" : "application/json"]
        
        session = NSURLSession(configuration: config)
    }
    
    func downloadData(complerionHandler completion: ()->Void) {
        
        let resourceURL = NSURL(string: "https://api.parse.com/1/classes/Band")
        let currentRequest = NSURLRequest(URL: resourceURL!)
        
        let task = session.dataTaskWithRequest(currentRequest) { (let data, let response, let error) -> Void in
            if ((response?.respondsToSelector("statusCode")) != nil) {
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        self.parseJSONFromData(data!)
                        if self.jsonDictionary != nil {
                            completion()
                        }
                    } else {
                        print("HTTPResponse status code - \(httpResponse.statusCode)")
                    }
                }
            } else {
                print("Error - doesn't respond to Status Code")
            }
            if error != nil {
                print("Data task error - \(error)")
            }
            
        }
        task.resume()
    }
    
    func parseJSONFromData(data: NSData) {
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let dict = jsonDictionary as? NSDictionary {
                self.jsonDictionary = dict
                //print(dict)
            }
        } catch {
            print("Error during parsing - \(error)")
        }
    }
    
    func createBands(jsonDictionary: NSDictionary?) -> [Band]? {
        if let dictionaties = jsonDictionary?.objectForKey("results") as? [[String : AnyObject]] {
                var bands = [Band]()
                for item in dictionaties {
                    let name = item["name"] as? String
                    let foundationYear = item["formationYear"] as? NSNumber
                    let shortInfo = item["shortDescription"] as? String
                    let genres = item["genres"] as? [String]
                //  let members = item["members"] as? [Member]
                    let currentBand = Band(bandName: name, shortInfo: shortInfo, foundationYear: foundationYear, membersOfBand: [], genres: genres)
                    if let newBand = currentBand {
                        bands.append(newBand)
                    }
                }
            return bands
        }
        return nil
    }
    
    
    
    
        
}
