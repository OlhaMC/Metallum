//
//  BandsViewController.swift
//  Metallum
//
//  Created by AppleTree on 3/8/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation
import UIKit

final class BandsViewController: UITableViewController {

    var bands = [Band]()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        title = "Bands"
        
        let bandsURL = NSURL(string: "https://api.backendless.com/v1/data/Band")
        
        if let bandsURL = bandsURL {
            createBandsUsingDataFromURL(bandsURL)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning. Need to handle.")
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bands.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(BandTableViewCell), forIndexPath: indexPath) as! BandTableViewCell
        configureBandTableViewCell(cell, atIndexPath:indexPath, forTableView:tableView)
        return cell;
    }
    
    func configureBandTableViewCell(cell: BandTableViewCell, atIndexPath: NSIndexPath, forTableView: UITableView) {
        let band = bands[atIndexPath.row]
        cell.bandName?.text = band.name
        let genres = band.genres.reduce("", combine: {$0 + "\($1), "})
        cell.genreTypes?.text = genres
        cell.year?.text = "\(band.formationYear)"
        cell.numberOfMembers?.text = "\(band.members.count)"
        cell.shortTextDescription?.text = band.shortDescription
    }
    
    //MARK: - Create contents for BandsTableVeiw
    
    func createBandsUsingDataFromURL(bandsURL: NSURL) {
        NetworkManager.sharedInstance.downloadDataFromURL(bandsURL) {[weak self] (jsonDictionary) -> Void in
            if let jsonDictionaries = jsonDictionary?.objectForKey("data") as? [[String : AnyObject]] {
                for item in jsonDictionaries {
                    let band = Band(jsonDictionary: item)
                    if let band = band {
                        self?.bands.append(band)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.tableView.reloadData()
                })
            }
        }
    }
    
    //MARK: - UITableViewDelegate
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailedInfoSegue" {
            let destinationViewController = segue.destinationViewController as? DetailedInfoViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let destinationViewController = destinationViewController, indexPath = indexPath {
                destinationViewController.band = bands[indexPath.row]
            }
        }
    }
}