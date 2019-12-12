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
    
    func loginUser(username: String, password: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<UserMO>(entityName: "User")
        
        request.predicate = NSPredicate(format: "uid == %@", username)
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [UserMO] = try context.fetch(request)
            
            print(result)
            
            if result.isEmpty {
                return false
            }
            
            let user = result[0]
            
            if user.password == nil || user.password != password {
                return false
            } else {
                setConnectedUser(uid: username)
                return true
            }
        } catch {
            print("cannot fetch the user")
            return false
        }
    }
    
    func signupUser(uid: String, psw: String, lastname: String, firstname: String) -> Bool {
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! UserMO
        newUser.setValue(uid, forKey: "uid")
        newUser.setValue(psw, forKey: "password")
        newUser.setValue(lastname, forKey: "lastName")
        newUser.setValue(firstname, forKey: "firstName")
        
        do {
            try context.save()
            setConnectedUser(uid: uid)
            return true
        } catch {
            return false
        }
        
    }
    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "connectedUser")
    }
    
    func setConnectedUser(uid: String) {
        UserDefaults.standard.set(uid, forKey: "connectedUser")
    }
    
}
