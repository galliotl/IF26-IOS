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
    private let dataSource = MusicTableDataSource()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupFeed()
        
    }
    
    func setupFeed() {

        dataSource.deletionClosure = { (indexPath) in
            self.confirmDeletion(deletionIndexPath: indexPath)
        }
        feedTableView.dataSource = dataSource
        feedTableView.delegate = self
        if #available(iOS 10.0, *) {
            feedTableView.refreshControl = refreshControl
        } else {
            feedTableView.addSubview(refreshControl)
        }
        if dataSource.list.isEmpty {
            fetchSongs()
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)

    }
    
    func fetchSongs() {
        
        DispatchQueue.main.async {
            self.dataSource.list = self.musicHelper.getMusics()
            self.feedTableView.reloadData()
        }
        
    }
    
    @objc private func refreshFeed(_ sender: Any) {
        
        fetchSongs()
        refreshControl.endRefreshing()
        
    }
}

extension FeedViewController: UITableViewDelegate {

    // click controler for a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // create new playlist from current position 'til the end of the playlist
        let playlist: [Music] = Array(dataSource.list[indexPath.row...])
        MusicService.getInstance().playPlaylist(playlist: playlist)
        
    }

    func confirmDeletion(deletionIndexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Delete Planet", message: "Are you sure you want to permanently delete the music?", preferredStyle: .actionSheet)
        
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
        
        let musicToDelete = dataSource.list[deletionIndexPath.row]
                
        // remove from device/db
        storageUtil.deleteFile(url: URL(fileURLWithPath: musicToDelete.path!))
        musicHelper.removeMusicFromDb(mid: musicToDelete.mid!)
        
        // remove from UI
        dataSource.list.remove(at: deletionIndexPath.row)
        feedTableView.deleteRows(at: [deletionIndexPath], with: .fade)
        
    }

}
