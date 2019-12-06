//
//  Switcher.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 02/12/2019.
//  Copyright © 2019 FILIPPI Eliott. All rights reserved.
//

import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        
        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main") as! MainViewController
        }
        else{
            //rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "disconnected") as! DisconnectedViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}

