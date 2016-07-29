//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Ankit Jasuja on 7/28/16.
//  Copyright © 2016 Ankit Jasuja. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func onCancel(sender: AnyObject) {
        print("cancelled chat view ... ")
    }
    
    @IBAction func onMessageSend(sender: AnyObject) {
    print(messageTextField.text!)
        let messageObject = PFObject(className: "Message_iOSFeb2016")
        let messageText = messageTextField.text!
        messageObject["text"] = messageText
        messageObject.saveInBackgroundWithBlock { (isSuccessful : Bool, error : NSError?) in
            if isSuccessful {
                print(messageText)
            } else {
                print(error)
            }
        }
        
    }
    
}
