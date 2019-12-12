//
//  RedirectHelper.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 12/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class RedirectHelper {
    static var instance: RedirectHelper? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private init() {}
    
    static func getInstance() -> RedirectHelper {
        if instance == nil {
            instance = RedirectHelper()
        }
        return instance!
    }
    
    func redirectToLogin() {
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "Disconnected", bundle: nil)
            let disconnectedVC = storyboard.instantiateViewController(withIdentifier: "disconnected") as! DisconnectedViewController
            disconnectedVC.modalPresentationStyle = .fullScreen
            self.appDelegate.window?.rootViewController = disconnectedVC
            
        }
    }
    
    func redirectToHomeScreen() {
        
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "main") as! MainViewController
            mainVC.modalPresentationStyle = .fullScreen
            self.appDelegate.window?.rootViewController = mainVC

        }
        
    }
}
