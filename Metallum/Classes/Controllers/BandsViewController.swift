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
        
        let bandsURL = NSURL(string: "https://api.backendless.com/v1/data/Band")
        let albumsURL = NSURL(string: "https://api.backendless.com/v1/data/Album")
        
        if let bandsURL = bandsURL, albumsURL = albumsURL {
            createBandsUsingDataFromURL(bandsURL, albumsURL: albumsURL)
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
    
    func createBandsUsingDataFromURL(bandsURL: NSURL, albumsURL: NSURL) {
        NetworkManager.sharedInstance.downloadDataFromURL(bandsURL) {[weak self] (jsonDictionary) -> Void in
            if let jsonDictionaries = jsonDictionary?.objectForKey("data") as? [[String : AnyObject]] {
                for item in jsonDictionaries {
                    let band = Band(jsonDictionary: item)
                    if let band = band {
                        self?.bands.append(band)
                    }
                }
                if let bands = self?.bands {
                    self?.createAlbumsForBands(bands, albumsURL: albumsURL)
                }
            }
        }
    }
    
    func createAlbumsForBands(bands: [Band], albumsURL: NSURL) {
        NetworkManager.sharedInstance.downloadDataFromURL(albumsURL) {[weak self] (jsonDictionary) -> Void in
            if let jsonDictionaries = jsonDictionary?.objectForKey("data") as? [[String : AnyObject]] {
                var albumsArray = [Album]()
                for item in jsonDictionaries {
                    let album = Album(jsonDictionary: item)
                    if let album = album {
                        albumsArray.append(album)
                    }
                }
                
                for band in bands {
                    for album in albumsArray {
                        if band.albumsIds.containsString(album.objectId) {
                            band.albums.append(album)
                        }
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