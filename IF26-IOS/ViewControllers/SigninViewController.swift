//
//  SigninViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 06/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreData

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
            signupFailed()
        } else {
            signupSucceded()
        }
                
    }
    
    func addToDb() -> Bool {
        
        let context = appDelegate.persistentContainer.viewContext
         
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into:context)
        newUser.setValue(identifiant.text, forKey:"id")
        newUser.setValue(password.text, forKey:"password")
        newUser.setValue(firstname, forKey: "firstname")
        newUser.setValue(lastname, forKey: "lastname")
        
        do {
            try context.save()
            return true
        } catch  {
            print("Erreur")
            return false
        }
    }
    
    func signupFailed() {
        alert.text = "user already exists"
    }
    
    func signupSucceded() {
        alert.text = "signup succeded"
    }
    
}
