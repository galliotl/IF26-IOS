//
//  LoginViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.text = ""
    }
    
    @IBAction func login_button(_ sender: UIButton) {
        
        if getLoginResult() {
            loginSucceded()
        } else {
            loginFailed()
        }
        
    }
    
    func getLoginResult() -> Bool {
        
        let typedId = id.text
        let typedPsw = password.text
        
        if typedId == nil || typedPsw == nil {
            return false
        }
        
        return LoginHelper.getInstance().loginUser(username: typedId!, pasword: typedPsw!)
    
    }
    
    func loginFailed() {
        alert.text = "login failed"
    }

    func loginSucceded() {
        alert.text = "login succeded"
        Switcher.loadHomeScreen()
    }
}
