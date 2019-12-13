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
    
    var userData: UserMO? = nil
    var coreDataStack = CoreDataStack() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        userLabel.text = "\(userData?.firstName ?? "") \(userData?.lastName ?? "")"
        
    }
    
    
    @IBAction func logoff(_ sender: Any) {
        
        LoginHelper.getInstance().logoutUser()
        redirectUserToLoginScreen()
        
    }

    func loadUserData() {

        guard let userId = LoginHelper.getInstance().getConnectedUserId() else {
            redirectUserToLoginScreen()
            return
        }
        let request = NSFetchRequest<UserMO>(entityName: "User")
        
        request.predicate = NSPredicate(format: "uid == %@", userId)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result: [UserMO] = try coreDataStack.managedObjectContext.fetch(request)
                        
            if result.isEmpty {
                redirectUserToLoginScreen()
                return
            }
            userData = result[0]
            
        } catch {
            print("cannot fetch the user")
            redirectUserToLoginScreen()
            return
        }

    }
    
    func redirectUserToLoginScreen() {
        RedirectHelper.getInstance().redirectToLogin()
    }
    
}
