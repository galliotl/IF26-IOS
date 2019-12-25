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
    @IBOutlet weak var myTableView: UITableView!
    
    var feedsongs:[Music] = []
    var deletionIndexPath: IndexPath? = nil
    private let refreshControl = UIRefreshControl()
    
    lazy var musicHelper = MusicHelper()
    lazy var storageUtil = StorageUtil()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupFeed()
        
    }
    
    func setupFeed() {
        
        if #available(iOS 10.0, *) {
            feedTableView.refreshControl = refreshControl
        } else {
            feedTableView.addSubview(refreshControl)
        }
        if feedsongs.isEmpty {
            fetchSongs()
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)

    }
    
    func fetchSongs() {
        
        DispatchQueue.main.async {
            self.feedsongs = self.musicHelper.getMusics()
            self.myTableView.reloadData()
        }
        
    }    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as! MusicCell
        let song = feedsongs[indexPath.row]
        cell.title?.text = song.title
        cell.artist?.text = "\(song.artist?.firstName ?? "") \(song.artist?.lastName ?? "")"
        let btn = cell.favBtn
        
        cell.favClosure = { () in
            self.favClicked(song: song, btn: btn!)
        }
        
        if LoginHelper.getInstance().getConnectedUserData()!.hasFaved(music: song) {
            btn?.setTitle("unFav", for: .normal)
        }
        return cell
        
    }

    func favClicked(song: Music, btn: UIButton) {
        
        guard (LoginHelper.getInstance().getConnectedUserData() != nil) else {
            print("no user")
            return
        }
        
        if musicHelper.switchFav(user: LoginHelper.getInstance().getConnectedUserData()!, music: song) {
            // faved has been added
            btn.setTitle("unFav", for: .normal)
        } else {
            // faved has been removed
            btn.setTitle("Fav", for: .normal)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // create new playlist from current position 'til the end of the playlist
        let playlist: [Music] = Array(feedsongs[indexPath.row...])
        MusicService.getInstance().playPlaylist(playlist: playlist)
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletionIndexPath = indexPath
            confirmDeletion()
        }
    }
    
    func confirmDeletion() {
        
        let alert = UIAlertController(title: "Delete Planet", message: "Are you sure you want to permanently delete the music?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDelete)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDelete)
    
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
    
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleDelete(alertAction: UIAlertAction!){
        
        if deletionIndexPath == nil {
            print("no item selected")
            return
        }
        let musicToDelete = feedsongs[deletionIndexPath!.row]
                
        // remove from device/db
        storageUtil.deleteFile(url: URL(fileURLWithPath: musicToDelete.path!))
        musicHelper.removeMusicFromDb(mid: musicToDelete.mid!)
        
        // remove from UI
        feedsongs.remove(at: deletionIndexPath!.row)
        myTableView.deleteRows(at: [deletionIndexPath!], with: .fade)
        
    }
    
    func cancelDelete(alertAction: UIAlertAction!){
        deletionIndexPath = nil
    }
    
    @objc private func refreshFeed(_ sender: Any) {
        
        fetchSongs()
        refreshControl.endRefreshing()
        
    }

}
