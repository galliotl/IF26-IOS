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
    var connectedUserData: User?
    
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
                setConnectedUserData(user: user)
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
            setConnectedUserData(user: newUser)
            return true
        } catch {
            moc.delete(newUser)
            return false
        }
        
    }
    
    func logoutUser() {
        
        UserDefaults.standard.removeObject(forKey: "connectedUser")
        connectedUserData = nil
        
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
    
    private func setConnectedUserData(user: User) {
        
        connectedUserData = user
        setConnectedUser(uid: user.uid!)
    
    }
    
    func removeUserData() {
        
        // fetch user
        
        
    }
}
