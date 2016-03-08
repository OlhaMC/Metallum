//
//  BandsViewController.swift
//  Metallum
//
//  Created by AppleTree on 3/8/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation

import UIKit

class BandsViewController: UITableViewController {

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
        dataManager?.downloadData(complerionHandler: {[unowned self] () -> Void in
            self.bands = self.dataManager?.createBands(self.dataManager?.jsonDictionary)
            if let someBands = self.bands {
                for band in someBands {
                    band.showBandInfo()
                }
                self.tableView.reloadData()
            }
        })
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning. Need to handle.")
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let bandNumb = bands?.count {
            return bandNumb
        } else {
          return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BandCell", forIndexPath: indexPath) as? BandCell
        
        configureTileCell(cell!, atIndexPath:indexPath, forTableView:tableView)
        
        return cell!;
    }
    
    func configureTileCell(cell: BandCell, atIndexPath: NSIndexPath, forTableView: UITableView) {
        if let currentBand = bands?[atIndexPath.row] {
            cell.bandName?.text = currentBand.name
            cell.genreTypes?.text = currentBand.genres?.description
            
            if let year = currentBand.formationYear {
                cell.year?.text = "\(year)"
            } else {
                cell.year?.text = "N/A"
            }
            
            cell.numberOfMembers?.text = "\(currentBand.members.count)"
            cell.shortTextDescription?.text = currentBand.shortDescription
            cell.contentView.sizeToFit()
        }
    }
}