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
    
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject] = []
    
    @IBAction func onCancel(sender: AnyObject) {
        print("cancelled chat view ... ")
    }
    
    override func viewDidLoad() {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "refreshMessages", userInfo: nil, repeats: true)
        messageTableView.dataSource = self
        messageTableView.reloadData()
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
    
    func refreshMessages() -> Void {
        print("refreshing messages ... ")
        let query = PFQuery(className: "Message_iOSFeb2016")
//        query.addAscendingOrder("createdAt")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects : [PFObject]?, error : NSError?) in
            print("retrieved \(objects!.count) messages ... ")
            if let messages = objects {
                self.messages = messages
            }
            self.messageTableView.reloadData()
        }
        
    }
   
}


extension ChatViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatMessageCell") as! ChatMessageCell
        let message = messages[indexPath.row]
        if let text = message["text"] as? String {
            if text != "" {
                cell.messageLabel.text = text
            }
        }
        return cell
    }
}
