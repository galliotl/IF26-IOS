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
    var coreDataStack = CoreDataStack(){ }

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
        
        let request = NSFetchRequest<UserMO>(entityName: "User")
        
        request.predicate = NSPredicate(format: "uid == %@", username)
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [UserMO] = try coreDataStack.managedObjectContext.fetch(request)
                        
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
                
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: coreDataStack.managedObjectContext) as! UserMO
        newUser.setValue(uid, forKey: "uid")
        newUser.setValue(psw, forKey: "password")
        newUser.setValue(lastname, forKey: "lastName")
        newUser.setValue(firstname, forKey: "firstName")
        
        do {
            try coreDataStack.managedObjectContext.save()
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
