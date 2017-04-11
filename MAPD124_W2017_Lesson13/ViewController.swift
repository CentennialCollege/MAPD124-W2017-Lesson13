//
//  ViewController.swift
//  MAPD124_W2017_Lesson13
//
//  Created by Tom Tsiliopoulos on 2017-04-11.
//  Copyright © 2017 Tom Tsiliopoulos. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var isGrantedPermission = false

    @IBAction func SendANotification(_ sender: UIButton) {
        if(isGrantedPermission) {
            // Step 1 - create a content object
            let content = UNMutableNotificationContent()
            content.title = "New Notification!"
            content.body = "Here is the body of your notification"
            
            // Step 2 - create a trigger object
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            
            // Step 3 - create a request object (container for the notification request)
            let request  = UNNotificationRequest(identifier: "message.new", content: content, trigger: trigger)
            
            // Step 4 - add the request to the notification center
            UNUserNotificationCenter.current().add(request) {
                (error) in
                if(error != nil) {
                    print("error adding notification")
                }
            }
            
        }
    }
    
    @IBAction func ViewPendingNotifications(_ sender: UIButton) {
    }
    
    @IBAction func ViewDeliveredNotifications(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        { (isGranted, error) in
            self.isGrantedPermission = isGranted
            if(!isGranted) {
                // display a message that lets the user know that they will not recieve notifications
            }
        }
        
    }



}

