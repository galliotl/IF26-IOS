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
    @IBOutlet weak var favedTableView: UITableView!

    private let refreshControl = UIRefreshControl()

    lazy var musicHelper = MusicHelper()
    lazy var storageUtil = StorageUtil()
    private let dataController = MusicTableController()

    var userData: User? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadUserData()
        setupFeed()
        userLabel.text = "\(userData?.firstName ?? "") \(userData?.lastName ?? "")"
        
    }
    
}

// MARK: - Song part
extension AccountViewController {
    
    func fetchSongs() {
        
        DispatchQueue.main.async {
            guard let user = self.userData else {
                return
            }
            self.dataController.list = self.musicHelper.getFavedMusics(user: user)
            self.favedTableView.reloadData()
        }
        
    }
    
    @objc private func refreshFeed(_ sender: Any) {
        
        fetchSongs()
        refreshControl.endRefreshing()
        
    }
    
    func setupFeed() {

        dataController.deletionClosure = { (indexPath) in
            self.confirmDeletion(deletionIndexPath: indexPath)
        }
        favedTableView.dataSource = dataController
        favedTableView.delegate = dataController
        if #available(iOS 10.0, *) {
            favedTableView.refreshControl = refreshControl
        } else {
            favedTableView.addSubview(refreshControl)
        }
        if dataController.list.isEmpty {
            fetchSongs()
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)

    }
    
}

// MARK: - Deletion closure
extension AccountViewController {
    
    func confirmDeletion(deletionIndexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Delete Music", message: "Are you sure you want to permanently delete the music?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(alertAction) in
            self.handleDelete(alertAction: alertAction, deletionIndexPath: deletionIndexPath)
        })
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alertAction) in
            
        })
    
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
    
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleDelete(alertAction: UIAlertAction!, deletionIndexPath: IndexPath){
        
        let musicToDelete = dataController.list[deletionIndexPath.row]
                
        // remove from device/db
        musicHelper.removeMusicFromDb(mid: musicToDelete.mid!)
        
        // remove from UI
        dataController.list.remove(at: deletionIndexPath.row)
        favedTableView.deleteRows(at: [deletionIndexPath], with: .fade)
        
    }
    
}

// MARK: - User functions parts

extension AccountViewController {
    
    @IBAction func logoff(_ sender: Any) {
         
         LoginHelper.getInstance().logoutUser()
         redirectUserToLoginScreen()
         
     }

     @IBAction func deleteAccount(_ sender: Any) {
         
         if LoginHelper.getInstance().deleteAccount() {
             redirectUserToLoginScreen()
         }
         
     }
     
     func loadUserData() {
         userData = LoginHelper.getInstance().getConnectedUserData()
     }
     
     func redirectUserToLoginScreen() {
         RedirectHelper.getInstance().redirectToLogin()
     }
    
}
