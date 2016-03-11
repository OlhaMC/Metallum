//
//  NetworkManager.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    let session: NSURLSession
    
    private init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 60.0
        configuration.HTTPAdditionalHeaders = ["application-id" : "D65ECD64-92B7-4FC8-FF53-CC8CB9314200",
                                        "secret-key" : "663FD35E-769A-3B6A-FF9D-7C3376D3C200",
                                        "application-type" : "REST"]
        
        session = NSURLSession(configuration: configuration)
    }
    
    func downloadData(completionHandler completion: (jsonDictionary: NSDictionary?)->Void) {
        let resourceURL = NSURL(string: "https://api.backendless.com/v1/data/Band")
        if let resourceURL = resourceURL {
            let currentRequest = NSURLRequest(URL: resourceURL)
            
            let task = session.dataTaskWithRequest(currentRequest) {[weak self] (let data, let response, let error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let data = data {
                            let jsonDictionary = self!.parseJSONFromData(data)
                            completion(jsonDictionary: jsonDictionary)
                        }
                    } else {
                        print("HTTPResponse status code - \(httpResponse.statusCode)")
                    }
                }
                if let error = error {
                    print("Data task error - \(error)")
                }
            }
            task.resume()
        }
    }
    
    func parseJSONFromData(data: NSData) -> NSDictionary? {
        do {
            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let jsonDictionary = jsonDictionary as? NSDictionary {
                return jsonDictionary
            }
        } catch {
            print("Error during parsing - \(error)")
        }
        return nil
    }
        
}
