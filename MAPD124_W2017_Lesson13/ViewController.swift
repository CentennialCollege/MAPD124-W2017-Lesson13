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

