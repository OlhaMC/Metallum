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
        config.HTTPAdditionalHeaders = ["application-id" : "D65ECD64-92B7-4FC8-FF53-CC8CB9314200",
                                        "secret-key" : "663FD35E-769A-3B6A-FF9D-7C3376D3C200",
                                        "application-type" : "REST"]
        
        session = NSURLSession(configuration: config)
    }
    
    func downloadData(complerionHandler completion: ()->Void) {
        
        let resourceURL = NSURL(string: "https://api.backendless.com/v1/data/Band")
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
        
         if let dictionaties = jsonDictionary?.objectForKey("data") as? [[String : AnyObject]] {
                var bands = [Band]()
                for item in dictionaties {
                    let name = item["name"] as? String
                    let foundationYear = item["formationYear"] as? NSNumber
                    let shortInfo = item["shortDescription"] as? String
                    let genrString = item["genres"] as? String
                    let genArray = genrString?.componentsSeparatedByString(", ")
                    
                    let people = item["members"] as? [[String : AnyObject]]
                    var bandMembers = [Member]()
                    if let realPeople = people {
                        for person in realPeople {
                            let firstName = person["firstName"] as? String
                            let lastName = person["lastName"] as? String
                            let nickname = person["nickname"] as? String
                            
                            var birthDate = NSDate()
                            let dateNumber = person["birthDate"] as? NSNumber
                            if let doubleNumber = dateNumber {
                                 birthDate = NSDate(timeIntervalSince1970: Double(doubleNumber)/1000.0)
                            }
                            
                            let instrumentsString = person["instruments"] as? String
                            let instrumentsArray = instrumentsString?.componentsSeparatedByString(", ")
                            
                            if let nickName = nickname {
                                let currentMember = Member(name: firstName, lastName: lastName, nick: nickName, birthday: birthDate, bandInstruments: instrumentsArray)
                                bandMembers.append(currentMember)
                            }
                        }
                    }
                    
                    let currentBand = Band(bandName: name, shortInfo: shortInfo, foundationYear: foundationYear, membersOfBand: bandMembers, genres: genArray)
                    if let newBand = currentBand {
                        bands.append(newBand)
                    }
                }
            return bands
        }
        return nil
    }
    
  
        
}
