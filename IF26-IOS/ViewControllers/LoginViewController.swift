//
//  LoginViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreData

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
        UserDefaults.standard.set(true,  forKey: "status")
        // Switcher.updateRootVC()
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
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<UserMO>(entityName: "User")
        
        request.predicate = NSPredicate(format: "id = %@", typedId!)
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [UserMO] = try context.fetch(request)
            let user = result[0]
            if user.password == nil || user.password != typedPsw {
                return false
            } else {
                return true
            }
        } catch {
            print("cannot fetch the user")
            return false
        }
    }
    
    func loginFailed() {
        alert.text = "login failed"
    }

    func loginSucceded() {
        alert.text = "login succeded"
    }
}
