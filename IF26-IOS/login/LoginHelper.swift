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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moc: NSManagedObjectContext
    
    init() {
        moc = appDelegate.coreDataStack.managedObjectContext
    }
    
    func loginUser(username: String, password: String) -> Bool {
        
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "uid == %@", username)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result: [User] = try moc.fetch(request)
            
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
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: moc) as! User
        newUser.uid = uid
        newUser.password = psw
        newUser.lastName = lastname
        newUser.firstName = firstname
        
        do {
            try moc.save()
            setConnectedUser(uid: uid)
            return true
        } catch {
            moc.delete(newUser)
            return false
        }
        
    }
    
    func logoutUser() {
        
        UserDefaults.standard.removeObject(forKey: "connectedUser")
        
    }
    
    func getConnectedUserId() -> String? {
        return UserDefaults.standard.string(forKey: "connectedUser")
    }
    
    func getConnectedUserData() -> User? {

        guard let userId = getConnectedUserId() else {
            return nil
        }
        
        // fetch request
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "uid == %@", userId)
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [User] = try moc.fetch(request)
            if result.isEmpty {
                return nil
            }
            return result[0]
        } catch {
            print("cannot fetch the user")
            return nil
        }

    }
    
    private func setConnectedUser(uid: String) {
        UserDefaults.standard.set(uid, forKey: "connectedUser")
    }
    
    func deleteAccount() -> Bool {
        
        guard let currentUser = getConnectedUserData() else {
            print("no connected user")
            return false
        }
        
        moc.delete(currentUser)
        
        do {
            try moc.save()
            logoutUser()
            return true
        } catch {
            print("cannot do that")
            return false
        }

    }
}
