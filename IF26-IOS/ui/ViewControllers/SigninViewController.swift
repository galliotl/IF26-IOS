//
//  SigninViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 06/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var identifiant: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        alert.text = ""
    }
    
        
    @IBAction func signup(_ sender: UIButton) {
        
        if addToDb() {
            signupSucceded()
        } else {
            signupFailed()
        }
                
    }
    
    func addToDb() -> Bool {
        
        guard let uid = identifiant.text, !uid.isEmpty else {
            return false
        }
        
        guard let psw = password.text, !psw.isEmpty else {
            return false
        }
        
        guard let firstname = self.firstname.text, !firstname.isEmpty else {
            return false
        }
        
        guard let lastname = self.firstname.text, !lastname.isEmpty else {
            return false
        }
        return LoginHelper.getInstance().signupUser(uid: uid, psw: psw, lastname: lastname, firstname: firstname)

    }
    
    func signupFailed() {
        
        alert.text = "signup failed"
        lastname.text = ""
        firstname.text = ""
        password.text = ""
        identifiant.text = ""
        
    }
    
    func signupSucceded() {
        alert.text = "signup succeded"
        redirectToHomeScreen()
    }
    
    func redirectToHomeScreen() {
        RedirectHelper.getInstance().redirectToHomeScreen()
    }
}
