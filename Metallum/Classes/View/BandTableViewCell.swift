//
//  BandTableViewCell.swift
//  Metallum
//
//  Created by AppleTree on 3/8/16.
//  Copyright © 2016 OlhaF. All rights reserved.
//

import Foundation
import UIKit

final class BandTableViewCell: UITableViewCell {
    
    @IBOutlet var bandName: UILabel?
    @IBOutlet var genreTypes: UILabel?
    @IBOutlet var year: UILabel?
    @IBOutlet var numberOfMembers: UILabel?
    @IBOutlet var shortTextDescription: UILabel?
}