//
//  BandCell.swift
//  Metallum
//
//  Created by AppleTree on 3/8/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation
import UIKit

class BandCell: UITableViewCell {
    
    @IBOutlet var bandName: UILabel?
    @IBOutlet var genreTypes: UILabel?
    @IBOutlet var year: UILabel?
    @IBOutlet var numberOfMembers: UILabel?
    @IBOutlet var shortTextDescription: UILabel?
    
//    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
//        
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
    
  //  init(name: String, genres: [String]?, foundationYear: NSNumber?, membersNumber: UInt, info: String?) {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

//        bandName!.text = name
//        if genres != nil {
//            genreTypes!.text = genres![0]
//        }
//        year!.text = "\(foundationYear)"
//        numberOfMembers!.text = "\(membersNumber)"
//        shortTextDescription!.text = info
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        bandName.text = "Default name"
//        if genres != nil {
//            genreTypes!.text = genres![0]
//        }
//        year.text = "\(0)"
//        numberOfMembers.text = "\(0)"
//        shortTextDescription.text = "No info"
        super.init(coder: aDecoder)
    }
}