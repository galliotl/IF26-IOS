//
//  LoginHelper.swift
//  IF26-IOS
//
//  Created by GALLIOT Lucas on 10/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreData

class LoginHelper {
    
    static var instance: LoginHelper? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private init() {}
    
    static func getInstance() -> LoginHelper {
        if instance == nil {
            instance = LoginHelper()
        }
        return instance!
    }
    
    func getConnectedUserId() -> String? {
        return UserDefaults.standard.string(forKey: "connectedUser")
    }
    
    func loginUser(username: String, pasword: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<UserMO>(entityName: "User")
        
        request.predicate = NSPredicate(format: "id == %@", username)
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [UserMO] = try context.fetch(request)
            let user = result[0]
            
            if user.password == nil || user.password != pasword {
                return false
            } else {
                UserDefaults.standard.set(user.uid, forKey: "connectedUser")
                return true
            }
        } catch {
            print("cannot fetch the user")
            return false
        }
    }
    
}
