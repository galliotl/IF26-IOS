//
//  MusicTableView.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 24/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class MusicTableController: NSObject, UITableViewDataSource, UITableViewDelegate {

    var list = [Music]()
    lazy var musicHelper = MusicHelper()
    var deletionClosure: ((IndexPath) -> Void)?
    var deletionIndexPath: IndexPath?
    var fetchSongs: (() -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as! MusicCell
        let song = list[indexPath.row]
        cell.title?.text = song.title
        cell.artist?.text = "\(song.artist?.firstName ?? "") \(song.artist?.lastName ?? "")"
        let btn = cell.favBtn
        
        cell.favClosure = { () in
            self.favClicked(song: song, btn: btn!)
        }
        
        if LoginHelper.getInstance().getConnectedUserData()!.hasFaved(music: song) {
            if #available(iOS 13.0, *) {
                btn?.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
            } else {
                btn?.setImage(nil, for: .normal)
                btn?.setTitle("unFav", for: .normal)
            }
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
            if #available(iOS 13.0, *) {
                btn.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
            } else {
                btn.setImage(nil, for: .normal)
                btn.setTitle("unFav", for: .normal)
            }
        } else {
            // faved has been removed
            if #available(iOS 13.0, *) {
                btn.setImage(UIImage.init(systemName: "heart"), for: .normal)
            } else {
                btn.setImage(nil, for: .normal)
                btn.setTitle("fav", for: .normal)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletionIndexPath = indexPath
            deletionClosure?(indexPath)
        }
    }
    
    // click controler for a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // create new playlist from current position 'til the end of the playlist
        let playlist: [Music] = Array(list[indexPath.row...])
        MusicService.getInstance().playPlaylist(playlist: playlist)
        
    }
    
}
