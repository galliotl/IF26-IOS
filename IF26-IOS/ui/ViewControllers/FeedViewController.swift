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
    
    @IBOutlet weak var myTableView: UITableView!
    var feedsongs:[String] = []
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var feedTableView: UITableView!
    
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
            gettingSongNames()
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)

    }
    
    func gettingSongNames() {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
        feedsongs = []
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath {
                var mySong = song.absoluteString
                if mySong.contains(".mp3") {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    feedsongs.append(mySong)
                }
            }
        }
        catch
        {
            print ("ERROR fetching data")
        }
        myTableView.reloadData()
    }    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as! MusicCell
        cell.title?.text = feedsongs[indexPath.row]
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // create new playlist from current position 'til the end of the playlist
        let playlist: [String] = Array(feedsongs[indexPath.row...])
        MusicService.getInstance().playPlaylist(playlist: playlist)
        
    }
    
    @objc private func refreshFeed(_ sender: Any) {
        gettingSongNames()
        refreshControl.endRefreshing()
    }

}
