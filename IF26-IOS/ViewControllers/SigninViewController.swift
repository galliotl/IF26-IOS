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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     
        
        
        
    }
    
        
    @IBAction func signup(_ sender: UIButton) {
        
        /*
         print("222")
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appDelegate.persistentContainer.viewContext
         
         let newModule = NSEntityDescription.insertNewObject(forEntityName: "Database", into:context)
         newModule.setValue(identifiant.text, forKey:"identifiant")
         newModule.setValue(password.text, forKey:"password")
         
         do {
         try context.save()
         print("context saved")
         } catch  {
         print("Erreur")
         }
         */
        
    }
    
    

 
    
    
    
}
