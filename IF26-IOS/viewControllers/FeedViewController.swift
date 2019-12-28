//
//  FeedControllerViewController.swift
//  IF26-IOS
//
//  Created by GALLIOT Lucas on 27/11/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import MobileCoreServices

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    lazy var musicHelper = MusicHelper()
    lazy var storageUtil = StorageUtil()
    private let dataController = MusicTableController()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupFeed()
        
    }
    
}

// MARK: - Song part
extension FeedViewController {
    
    func fetchSongs() {
        
        DispatchQueue.main.async {
            self.dataController.list = self.musicHelper.getMusics()
            self.feedTableView.reloadData()
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
        feedTableView.dataSource = dataController
        feedTableView.delegate = dataController
        if #available(iOS 10.0, *) {
            feedTableView.refreshControl = refreshControl
        } else {
            feedTableView.addSubview(refreshControl)
        }
        if dataController.list.isEmpty {
            fetchSongs()
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)

    }
    
}

// MARK: - Deletion closure
extension FeedViewController {
    
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
        feedTableView.deleteRows(at: [deletionIndexPath], with: .fade)
        
    }
    
}
