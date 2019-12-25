//
//  AccountViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    var userData: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        userLabel.text = "\(userData?.firstName ?? "") \(userData?.lastName ?? "")"
        
    }
    
    
    @IBAction func logoff(_ sender: Any) {
        
        LoginHelper.getInstance().logoutUser()
        redirectUserToLoginScreen()
        
    }

    @IBAction func deleteAccount(_ sender: Any) {
        
        if LoginHelper.getInstance().deleteAccount() {
            redirectUserToLoginScreen()
        }
        
    }
    
    func loadUserData() {
        userData = LoginHelper.getInstance().getConnectedUserData()
    }
    
    func redirectUserToLoginScreen() {
        RedirectHelper.getInstance().redirectToLogin()
    }
    
}
