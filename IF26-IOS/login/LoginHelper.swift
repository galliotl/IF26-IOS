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
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var moc: NSManagedObjectContext
    private var userData: User?
    
    static func getInstance() -> LoginHelper {
        
        if instance == nil {
            instance = LoginHelper()
        }
        return instance!
    }
    
    private init() {
        moc = appDelegate.coreDataStack.managedObjectContext
    }
    
    func fetchUserData(uid: String) -> User? {

        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "uid == %@", uid)
        request.returnsObjectsAsFaults = false

        do {
            
            let result: [User] = try moc.fetch(request)
            
            if result.isEmpty {
                print("no results for user")
                return nil
            }
            
            let user = result[0]
            return user
        
        } catch {
            print("cannot fetch the user")
            return nil
        }
        
    }
    
    func loginUser(username: String, password: String) -> Bool {
        
        guard let user = fetchUserData(uid: username) else {
            return false
        }
        
        if user.password == nil || user.password != password {
            return false
        } else {
            setConnectedUserData(user: user)
            return true
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
        userData = nil
        
    }
    
    func getConnectedUserId() -> String? {
        return UserDefaults.standard.string(forKey: "connectedUser")
    }
    
    func isUserConnected() -> Bool {
        return getConnectedUserId() != nil
    }
    
    func getConnectedUserData() -> User? {
        if isUserConnected() && userData == nil {
            userData = fetchUserData(uid: getConnectedUserId()!)
        }
        return userData
    }
    
    private func setConnectedUser(uid: String) {
        UserDefaults.standard.set(uid, forKey: "connectedUser")
    }
    
    private func setConnectedUserData(user: User) {
        setConnectedUser(uid: user.uid!)
        userData = user
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
