//
//  MainViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    let loginHelper = LoginHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isUserConnected() {
            redirectUserToLoginScreen()
        }

    }
    
    func isUserConnected() -> Bool {
        
        let connectedUser = loginHelper.getConnectedUserId()
        return connectedUser != nil && connectedUser != ""
    
    }
    
    func redirectUserToLoginScreen() {
        RedirectHelper.getInstance().redirectToLogin()
    }

}
