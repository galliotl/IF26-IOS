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
        label.text = musicService.getCurrentSongInfo()?.title
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
             displayPlay()
         } else {
             // play
             musicService.play()
             displayPause()
         }
        
    }
    
    @IBAction func prev(_ sender: Any) {
        musicService.previous()
        label.text = musicService.getCurrentSongInfo()?.title
    }
    
    @IBAction func next(_ sender: Any) {
        musicService.next()
        label.text = musicService.getCurrentSongInfo()?.title
    }
    
    func setupPlayPauseBtn() {
        
        if musicService.audioStuffed {
            if musicService.isPlaying() {
                displayPause()
            }
            else {
                displayPlay()
            }
        } else {
            displayPlay()
        }
        
    }
    
    func displayPause() {
        if #available(iOS 13.0, *) {
            playPauseBtn.setTitle(nil, for: .normal)
            playPauseBtn.setImage(UIImage.init(systemName: "pause"), for: .normal)
        } else {
            playPauseBtn.setImage(nil, for: .normal)
            playPauseBtn.setTitle("pause", for: .normal)
        }
    }
    
    func displayPlay() {
        if #available(iOS 13.0, *) {
            playPauseBtn.setTitle(nil, for: .normal)
            playPauseBtn.setImage(UIImage.init(systemName: "play"), for: .normal)
        } else {
            playPauseBtn.setImage(nil, for: .normal)
            playPauseBtn.setTitle("play", for: .normal)
        }
    }
}
