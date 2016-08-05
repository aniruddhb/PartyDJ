//
//  LoginViewController.swift
//  PartyDJ
//
//  Created by Aniruddh Bharadwaj on 8/4/16.
//  Copyright © 2016 Aniruddh Bharadwaj. All rights reserved.
//

import UIKit
import TwitterKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButtonDidTouch(sender: UIButton) {
        // declare login manager to handle login
        let facebookLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        
        // declare set of login permissions
        let facebookLoginPermissions: [AnyObject]! = ["public_profile", "email", "user_friends"]
        
        // request login with manager
        facebookLoginManager.logInWithReadPermissions(facebookLoginPermissions, fromViewController: self) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) in
            // depending on result and error, present alert to user or segue to next view controller
            if error != nil {
                // configure and show login alert error to user
                let alert: UIAlertController = UIAlertController(title: "Login Error", message: "There was an error logging into Facebook. Please try again later :(", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else if result.isCancelled {
                // configure and show cancel alert error to user
                let alert: UIAlertController = UIAlertController(title: "Login Cancelled", message: "The login action was cancelled. I'm sad now :(", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // perform segue (for now, print success)
                print("success")
            }
        }
    }
    
    @IBAction func twitterButtonDidTouch(sender: UIButton) {
        // use fabric to login via twtr shared instance
        Twitter.sharedInstance().logInWithCompletion { (session: TWTRSession?, error: NSError?) in
            // if session isn't nil, login succesful. otherwise alert user
            if session == nil {
                // configure and show error alert to user
                let alert: UIAlertController = UIAlertController(title: "Login Error", message: "There was an error logging into Twitter. Please try again later :(", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // perform segue (for now, print success)
                print("success")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
