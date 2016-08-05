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
    var eventInformation: [(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // set nav bar title
        self.navigationController?.title = "Facebook Events"
        
        // set no seperators
        self.tableView.separatorStyle = .None
        
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
        let fbEventsRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/events?limit=100", parameters: params)
        
        // start req
        fbEventsRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) in
            // if error is nil, parse data. otherwise, present alert to user
            if error == nil {
                // grab data array from result
                let resultData: [Dictionary<String, String>] = result["data"] as! [Dictionary<String, String>]
                
                // loop through array
                for eachEvent: Dictionary<String, String> in resultData {
                    let tupleInfo: (String, String) = (eachEvent["id"]!, eachEvent["name"]!)
                    self.eventInformation.append(tupleInfo)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
