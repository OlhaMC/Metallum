//
//  ViewController.swift
//  Metallum
//
//  Created by AppleTree on 3/3/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bands: [Band]?
    var members: [Member]?
    var dataManager: NetworkManager?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager = NetworkManager.sharedInstance
        if dataManager == nil {
            print("Error - network manager is nil")
            return
        }
        dataManager?.downloadData(complerionHandler: { () -> Void in
            self.bands = self.dataManager?.createBands(self.dataManager?.jsonDictionary)
            if let someBands = self.bands {
                for band in someBands {
                    band.showBandInfo()
                }
            }
        })
   
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

