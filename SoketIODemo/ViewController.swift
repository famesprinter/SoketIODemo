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

class ViewController: UIViewController {
    // MARK: - Variable
    let socket = SocketIOClient(socketURL: URL(string: "your URL")!,
                                config: [.log(true), .forcePolling(true)])
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("mobile-message") { data, ack in
            print("DATA: \(data)")
            self.displayNoti()
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
}

