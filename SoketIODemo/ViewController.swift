//
//  ViewController.swift
//  SoketIODemo
//
//  Created by Kittitat Rodphotong on 1/25/2560 BE.
//  Copyright © 2560 DevGo. All rights reserved.
//

import UIKit
import SocketIO
import BRYXBanner
import Alamofire

class ViewController: UIViewController {
    // MARK: - Variable
    let socket = SocketIOClient(socketURL: URL(string: "your url")!,
                                config: [.log(true),
                                         .forcePolling(true),
                                         .connectParams(["token" : "qwerty"])])
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("mobile-message") { data, ack in
            print("DATA: \(data)")
            self.displayNoti()
            self.displayLocalNoti()
        }
        
        socket.connect()
    }
    
    // MARK: - Function
    func displayNoti() {
        let banner = Banner(title: "Image Notification",
                            subtitle: "Here's a great image notification.", 
                            image: UIImage(named: "Icon"),
                            backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
    }
    
    func displayLocalNoti() {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 2) as Date
        notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": UIDevice.current.identifierForVendor!.uuidString]
        UIApplication.shared.scheduleLocalNotification(notification)
        
        guard let settings = UIApplication.shared.currentUserNotificationSettings else { return }
        
        if settings.types == .none {
            let ac = UIAlertController(title: "Can't schedule",
                                       message: "Either we don't have permission to schedule notifications, or we haven't asked yet.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            return
        }
    }
}

