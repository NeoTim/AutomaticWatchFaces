//
//  ViewController.swift
//  AutoWatchFaces
//
//  Created by Sylvain Guillier on 27/12/2018.
//  Copyright © 2018 Sylvain Guillier. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WCSessionDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    let watchList = WatchDatabase().watchDatabase
    var session : WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 112
        
        self.tableview.allowsSelection = true
        
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return watchList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchCell", for: indexPath)
        
        cell.imageView?.image = UIImage(named: watchList[indexPath.row].dial!)
        
        cell.textLabel?.text = String(watchList[indexPath.row].name)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        session.sendMessage(["CurrentWatch": indexPath.row], replyHandler: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
}

