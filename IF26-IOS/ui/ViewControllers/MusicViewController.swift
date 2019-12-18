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
    
    let musicService = MusicService.getInstance()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        label.text = musicService.getCurrentSongInfo()
        setupPlayPauseBtn()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playPause(_ sender: Any) {
        
         if musicService.isPlaying() {
             // pause
             musicService.pause()
             playPauseBtn.setTitle("play",for: .normal)
         } else {
             // play
             musicService.play()
             playPauseBtn.setTitle("pause",for: .normal)
         }
        
    }
    
    @IBAction func prev(_ sender: Any) {
        musicService.previous()
        label.text = musicService.getCurrentSongInfo()
    }
    
    @IBAction func next(_ sender: Any) {
        musicService.next()
        label.text = musicService.getCurrentSongInfo()
    }
    
    func setupPlayPauseBtn() {
        
        if musicService.audioStuffed {
            if musicService.isPlaying() {
                playPauseBtn.setTitle("pause",for: .normal)
            }
            else {
                playPauseBtn.setTitle("play",for: .normal)
            }
        }
        
    }
}
