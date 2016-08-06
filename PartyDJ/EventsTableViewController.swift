//
//  EventsTableViewController.swift
//  PartyDJ
//
//  Created by Aniruddh Bharadwaj on 8/5/16.
//  Copyright © 2016 Aniruddh Bharadwaj. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class EventsTableViewController: UITableViewController {
    
    /* local array of tuples to hold event id + event name */
    var eventInformation: [(String, String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // set nav bar title
        self.title = "Facebook Events"
    
        // load events into view
        populateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Functions
    
    func populateView() {
        // define fbrequest params
        let params = ["fields" : "name"]
        
        // define fbrequest
        let fbAllEventsRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/events?limit=100", parameters: params)
        
        // start req
        fbAllEventsRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, allEventsResult: AnyObject!, error: NSError!) in
            // if error is nil, parse data. otherwise, present alert to user
            if error == nil {
                // grab data array from result
                let resultData: [Dictionary<String, String>] = allEventsResult["data"] as! [Dictionary<String, String>]
                
                // loop through array
                for eachEvent: Dictionary<String, String> in resultData {
                    // construct request to find date of this event
                    var eventDate: String = ""
                    
                    // declare req to event
                    let fbEventRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/" + eachEvent["id"]!, parameters: params)
                    
                    // start req
                    fbEventRequest.startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) in
                        // if error is nil, get date of this event from req
                        if error == nil {
                            print(result)
                        } else {
                            eventDate = "Not found"
                        }
                    })
                    
                    
                    let tupleInfo: (String, String, String) = (eachEvent["id"]!, eachEvent["name"]!, "1/1/16")
                    self.eventInformation.append(tupleInfo)
                }
            }
            
            // reload tableview data
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.eventInformation.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> EventTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell

        // Configure the cell...
        cell.eventID = self.eventInformation[indexPath.row].0
        cell.eventName.text = self.eventInformation[indexPath.row].1 + " " + self.eventInformation[indexPath.row].2

        return cell
    }
}
