//
//  FeedControllerViewController.swift
//  IF26-IOS
//
//  Created by GALLIOT Lucas on 27/11/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import AVFoundation


var audioPlayer = AVAudioPlayer()
var feedsongs:[String] = []
var thisSong = 0
var audioStuffed = false

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingSongNames()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "feedcell")
        cell.textLabel?.text = feedsongs[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do
        {
            let audioPath = Bundle.main.path(forResource: feedsongs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)

            audioPlayer.play()
            thisSong = indexPath.row
            audioStuffed = true
        }
        catch
        {
            print ("ERROR playing data")
        }
    }

    func gettingSongNames() {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
        
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath
            {
                var mySong = song.absoluteString
                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    feedsongs.append(mySong)
                }
                
            }
            
            myTableView.reloadData()
        }
        catch
        {
            print ("ERROR fetching data")
        }
    }    
}
