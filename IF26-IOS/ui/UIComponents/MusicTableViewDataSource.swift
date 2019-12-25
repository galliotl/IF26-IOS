//
//  MusicTableView.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 24/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class MusicTableDataSource: NSObject, UITableViewDataSource {

    var list = [Music]()
    lazy var musicHelper = MusicHelper()
    var deletionClosure: ((IndexPath) -> Void)?
    var deletionIndexPath: IndexPath?
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletionIndexPath = indexPath
            deletionClosure?(indexPath)
        }
    }

    

}
