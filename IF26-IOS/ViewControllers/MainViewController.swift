//
//  MainViewController.swift
//  IF26-IOS
//
//  Created by FILIPPI Eliott on 05/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteAllData(entity: "User")
        deleteAllData(entity: "Music")
        deleteAllData(entity: "Favourite")
        
        if isUserConnected() == false {
            
            redirectUserToLoginScreen()
            
        }
    }
    
    func isUserConnected() -> Bool {
        
        let connectedUser = LoginHelper.getInstance().getConnectedUserId()
        return connectedUser != nil && connectedUser != ""
    
    }
    
    func redirectUserToLoginScreen() {
        
        DispatchQueue.main.async {
            
            self.dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Disconnected", bundle: nil)
            let disconnectedVC = storyboard.instantiateViewController(withIdentifier: "disconnected") as! DisconnectedViewController
            disconnectedVC.modalPresentationStyle = .fullScreen
            self.present(disconnectedVC, animated: true, completion: nil)
            
        }
        
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

}
