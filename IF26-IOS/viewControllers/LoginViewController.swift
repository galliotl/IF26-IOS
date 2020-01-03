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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.text = ""
        
        id.delegate = self
        password.delegate = self

    }
    
    @IBAction func login_button(_ sender: UIButton) {
        
        if getLoginResult() {
            loginSucceded()
        } else {
            loginFailed()
        }
        
    }
    
    func getLoginResult() -> Bool {
        
        guard let typedId = id.text, !typedId.isEmpty else {
            return false
        }
        guard let typedPsw = password.text, !typedPsw.isEmpty  else {
            return false
        }
        
        return LoginHelper.getInstance().loginUser(username: typedId, password: typedPsw)
    
    }
    
    func loginFailed() {
        alert.text = "login failed"
    }

    func loginSucceded() {
        alert.text = "login succeded"
        redirectToHomeScreen()
    }
    
    func redirectToHomeScreen() {
        RedirectHelper.getInstance().redirectToHomeScreen()
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
