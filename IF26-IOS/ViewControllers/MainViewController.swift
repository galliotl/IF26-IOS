//
//  MainViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUserConnected() == false {
            
            redirectUserToLoginScreen()
            
        }
    }
    
    func isUserConnected() -> Bool {
        
        let connectedUser = LoginHelper.getInstance().getConnectedUserId()
        return connectedUser != nil && connectedUser != ""
    
    }
    
    func redirectUserToLoginScreen() {
        
        DispatchQueue.main.async {
            
            self.dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Disconnected", bundle: nil)
            let disconnectedVC = storyboard.instantiateViewController(withIdentifier: "disconnected") as! DisconnectedViewController
            disconnectedVC.modalPresentationStyle = .fullScreen
            self.present(disconnectedVC, animated: true, completion: nil)
            
        }
        
    }

}
