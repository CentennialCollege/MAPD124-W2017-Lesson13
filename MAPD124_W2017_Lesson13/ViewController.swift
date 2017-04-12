//
//  ViewController.swift
//  MAPD124_W2017_Lesson13
//
//  Created by Tom Tsiliopoulos on 2017-04-11.
//  Copyright © 2017 Tom Tsiliopoulos. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    var notificationNumber = 0
    var isGrantedPermission = false

    
    func addNotification(content: UNMutableNotificationContent, trigger: UNNotificationTrigger?, identifier: String) {
        
        // Step 3 - create a request object (container for the notification request)
        let request  = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Step 4 - add the request to the notification center
        UNUserNotificationCenter.current().add(request) {
            (error) in
            if(error != nil) {
                print("error adding notification")
            }
            else {
                self.notificationNumber += 1
            }
        }

    }
    
    @IBAction func SendANotification(_ sender: UIButton) {
        if(isGrantedPermission) {
            // Step 1 - create a content object
            let content = UNMutableNotificationContent()
            content.title = "New Notification!"
            content.body = "Here is the body of your notification"
            
            // Step 2 - create a trigger object
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            
           addNotification(content: content, trigger: trigger, identifier: "message.simple.\(notificationNumber)")
        }
    }
    
    
    @IBAction func ScheduleANotification(_ sender: UIButton) {
        if(isGrantedPermission) {
            // Step 1 - Create a content object
            let content = UNMutableNotificationContent()
            content.title = "A Scheduled Notification"
            content.body = "Some Scheduled Content goes here...!"
            
            // Step 2 - setup your calendar / date object
            let units:Set<Calendar.Component> = [.minute, .hour, .second]
            var date = Calendar.current.dateComponents(units, from: Date())
            date.second = date.second! + 10
            
            // Step 3 - Create a trigger object
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            
            addNotification(content: content, trigger: trigger, identifier: "message.schedule.\(notificationNumber)")
        }
    }
    
    
    @IBAction func ViewPendingNotifications(_ sender: UIButton) {
        UNUserNotificationCenter.current().getPendingNotificationRequests
            { (requestList) in
            print("\(Date()) --> \(requestList.count) requests pending")
                for request in requestList {
                    print("\(request.identifier) body: \(request.content.body)")
                }
        }
    }
    
    @IBAction func ViewDeliveredNotifications(_ sender: UIButton) {
        UNUserNotificationCenter.current().getDeliveredNotifications
            { (notifications) in
            print("\(Date()) --> \(notifications.count) delivered")
                for notification in notifications {
                    print("\(notification.request.identifier)  \(notification.request.content.body)")
                }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        { (isGranted, error) in
            self.isGrantedPermission = isGranted
            if(!isGranted) {
                // display a message that lets the user know that they will not recieve notifications
            }
        }
    }

    // Delegates -------------
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

}

