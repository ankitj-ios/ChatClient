//
//  LoginViewController.swift
//  ChatClient
//
//  Created by Ankit Jasuja on 7/28/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onLogin(sender: AnyObject) {
        print("on login ... ")
        let username = emailTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) in
            if user != nil {
                print("login successful ...  \(user)" )
                self.performSegueWithIdentifier("ChatSegue", sender: nil)
            } else {
                print("login failed ... ")
                self.showAlertOnError("Login Failed", error: error!)
            }
        }
        print(user)
    }
    
    func showAlertOnError(alertTitle : String, error: NSError) -> Void {
        let errorMessage = error.localizedDescription
        let alertController = UIAlertController(title: alertTitle, message: errorMessage, preferredStyle: .Alert)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print("cancel action ... ")
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            print(" ok action ... ")
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
            print("after alert view is presented ... ")
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        print("on sign up ... ")
        let user = PFUser();
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.signUpInBackgroundWithBlock { (isSuccessful : Bool, error : NSError?) in
            if isSuccessful {
                print("sign up successful ... ")
                print(user)
                self.performSegueWithIdentifier("ChatSegue", sender: nil)
            } else {
                print("sign up failed ... \n")
                self.showAlertOnError("SignUp Failed", error: error!)
                
            }
        }
        
    }
    
//    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
//        <#code#>
//    }
}
