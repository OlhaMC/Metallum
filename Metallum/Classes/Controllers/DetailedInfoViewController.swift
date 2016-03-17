//
//  DetailedInfoViewController.swift
//  Metallum
//
//  Created by AppleTree on 3/15/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation
import UIKit

final class DetailedInfoViewController: UITableViewController {
    
    var band: Band!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 18.0
        tableView.estimatedRowHeight = 44.0
        title = band.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning. Need to handle.")
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return band.members.count
        case 3: return band.albums.count
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(InfoTableViewCell), forIndexPath: indexPath) as! InfoTableViewCell
            configureInfoTableViewCell(cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(MemberTableViewCell), forIndexPath: indexPath) as! MemberTableViewCell
            configureMemberTableViewCell(cell, atIndexPath:indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(AlbumTableViewCell), forIndexPath: indexPath) as! AlbumTableViewCell
            configureAlbumTableViewCell(cell, atIndexPath:indexPath)
            return cell
        default: return UITableViewCell()
        }
    }
    
    func configureInfoTableViewCell(cell: InfoTableViewCell) {
        cell.shortInfo.text = band.shortDescription
        cell.formationYear.text = String(band.formationYear)
        let genreString = band.genres.reduce("", combine: {$0 + "\($1), "})
        cell.typeOfGenres.text = genreString
    }
    
    func configureMemberTableViewCell(cell: MemberTableViewCell, atIndexPath: NSIndexPath) {
        let member = band.members[atIndexPath.row]
        cell.fullName.text = "\(member.firstName) \"\(member.nickName)\" \(member.lastName)"

        let calendar = NSCalendar.currentCalendar()
        if calendar.isDateInToday(member.birthDate) {
            cell.birthDay.text = "N/A"
        } else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            cell.birthDay.text = dateFormatter.stringFromDate(member.birthDate)
        }
    }
    
    func configureAlbumTableViewCell(cell: AlbumTableViewCell, atIndexPath: NSIndexPath) {
        let album = band.albums[atIndexPath.row]
        cell.albumName.text = album.title
        cell.yearReleased.text = String(album.releaseYear)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SectionHeaderTableViewCell)) as! SectionHeaderTableViewCell
        
        switch section {
            case 0: cell.sectionHeader.text = "Info"
            case 1: cell.sectionHeader.text = "Members"
            case 2: cell.sectionHeader.text = "Albums"
            default: cell.sectionHeader.text = ""
        }
        
        return cell
    }

}