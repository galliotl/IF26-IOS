//
//  Switcher.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 02/12/2019.
//  Copyright © 2019 FILIPPI Eliott. All rights reserved.
//

import UIKit

class Switcher {
    
    static func loadDisconnectedScreen(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "disconnected", bundle: nil)
        let disconnectedVC = storyBoard.instantiateViewController(withIdentifier: "DisconnectedViewController") as! DisconnectedViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = disconnectedVC
        
    }
    
    static func loadHomeScreen() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainVC

    }
    
}

