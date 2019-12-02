//
//  MusicViewController.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 02/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if feedsongs.isEmpty == false {
            label.text = feedsongs[thisSong]
        }
        
        if audioStuffed {
            if audioPlayer.isPlaying {
                playPauseBtn.setTitle("pause",for: .normal)
            }
            else {
                playPauseBtn.setTitle("play",for: .normal)
            }
        }
    }
    
    func playThis(thisOne:String) {
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            playPauseBtn.setTitle("pause",for: .normal)
        }
        catch {
            print ("ERROR playing the song")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playPause(_ sender: Any) {
        
         if audioPlayer.isPlaying {
             // pause
             audioPlayer.pause()
             playPauseBtn.setTitle("play",for: .normal)
         } else {
             // play
             audioPlayer.play()
             playPauseBtn.setTitle("pause",for: .normal)
         }
    }
    
    @IBAction func prev(_ sender: Any) {
        if thisSong != 0 && audioStuffed == true
        {
            playThis(thisOne: feedsongs[thisSong-1])
            thisSong -= 1
            label.text = feedsongs[thisSong]
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if thisSong < feedsongs.count-1 && audioStuffed == true
        {
            playThis(thisOne: feedsongs[thisSong+1])
            thisSong += 1
            label.text = feedsongs[thisSong]
        }
    }
}
