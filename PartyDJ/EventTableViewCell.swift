//
//  EventTableViewCell.swift
//  PartyDJ
//
//  Created by Aniruddh Bharadwaj on 8/5/16.
//  Copyright © 2016 Aniruddh Bharadwaj. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    /* IBOutlet to hold this event's name */
    @IBOutlet weak var eventName: UILabel!
    
    /* variable to hold this event's id (not displayed, for use in segue) */
    var eventID: String = ""
}
