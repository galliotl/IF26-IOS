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
        
        if !LoginHelper.getInstance().isUserConnected() {
            redirectUserToLoginScreen()
        }
        super.viewDidLoad()

    }
    
    func redirectUserToLoginScreen() {
        RedirectHelper.getInstance().redirectToLogin()
    }

}
