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
    var musicHelper = MusicHelper()
    var loginHelper = LoginHelper()
    
    private let refreshControl = UIRefreshControl()
    
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
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: cell, action: #selector(longPressed(press:)))
        cell.addGestureRecognizer(longPressGestureRecognizer)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // create new playlist from current position 'til the end of the playlist
        let playlist: [Music] = Array(feedsongs[indexPath.row...])
        MusicService.getInstance().playPlaylist(playlist: playlist)
        
    }
    
    @objc func longPressed(press: UILongPressGestureRecognizer) {
        
        // get the music
        let index = myTableView.indexPathForRow(at: press.location(in: myTableView))
        guard let row = index?.row else {
            // todo, show the user
            return
        }
        let music = feedsongs[row]
        
        // verify the user is the author
        guard let user = music.artist, user.uid == loginHelper.getConnectedUserId() else {
            print("music wasn't created by the user")
            // todo, show the user
            return
        }
    
        
        // are you sure?
        let alert = UIAlertController(title: nil, message: "Are you sure you want to delete?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)

        // remove it from db
        
        // remove it from storage
        
        // refresh feed
        myTableView.reloadData()
        
    }
    
    @objc private func refreshFeed(_ sender: Any) {
        
        fetchSongs()
        refreshControl.endRefreshing()
        
    }

}
