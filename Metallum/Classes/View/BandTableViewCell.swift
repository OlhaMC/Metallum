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
    
    @IBOutlet weak var bandName: UILabel?
    @IBOutlet weak var genreTypes: UILabel?
    @IBOutlet weak var year: UILabel?
    @IBOutlet weak var numberOfMembers: UILabel?
    @IBOutlet weak var shortTextDescription: UILabel?
}