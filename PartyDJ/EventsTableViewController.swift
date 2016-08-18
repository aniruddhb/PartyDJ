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
    
    /* local array of tuples to hold filtered events */
    var filteredEventInformation: [(String, String)] = []
    
    // search controller
    let searchController: UISearchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // set nav bar title
        self.title = "Facebook Events"
        
        // define parameters and properties for search controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
    
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
                    let tupleInfo: (String, String) = (eachEvent["id"]!, eachEvent["name"]!)
                    self.eventInformation.append(tupleInfo)
                }
            }
            
            // reload tableview data
            self.tableView.reloadData()
        }
    }
    
    func filterEventContent(searchText: String, scope: String = "ALL") {
        // filter content into new tuple array
        filteredEventInformation = eventInformation.filter({ (indivEventInfo: (String, String)) -> Bool in
            return indivEventInfo.1.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        // reload tableview
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != "" {
            return self.filteredEventInformation.count
        }
        
        return self.eventInformation.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> EventTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell

        // Configure the cell...
        if searchController.active && searchController.searchBar.text != "" {
            cell.eventID = self.filteredEventInformation[indexPath.row].0
            cell.eventName.text = self.filteredEventInformation[indexPath.row].1
        } else {
            cell.eventID = self.eventInformation[indexPath.row].0
            cell.eventName.text = self.eventInformation[indexPath.row].1
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // simple check if the correct event id still shows up
        if searchController.active && searchController.searchBar.text != "" {
            print(filteredEventInformation[indexPath.row].0)
        } else {
            print(eventInformation[indexPath.row].0)
        }
        
        // deselect this row
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

/* class extension for search feature */
extension EventsTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterEventContent(searchController.searchBar.text!)
    }
}
