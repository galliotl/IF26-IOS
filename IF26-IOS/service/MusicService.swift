//
//  MusicService.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 18/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import AVFoundation

class MusicService {
    static var instance: MusicService?
    
    var playlist: [Music] = []
    var audioPlayer = AVAudioPlayer()
    var thisSong = 0
    var audioStuffed = false

    private init() {}
    
    static func getInstance() -> MusicService {
        if instance == nil {
            instance = MusicService()
        }
        return instance!
    }
    
    func playPlaylist(playlist: [Music]) {
        
        self.playlist = playlist
        thisSong = 0
        playCurrentSong()
        
    }
    
    func playCurrentSong() {
        
        guard let musicPath = playlist[thisSong].path else {
            print("cannot play the music")
            return
        }
        do {
            
            try audioPlayer = AVAudioPlayer(contentsOf: URL(string: musicPath)!)
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioStuffed = true
            
        }
        catch {
            print ("ERROR playing data \n \(error)")
        }
        
    }
    
    func next() {
        
        if thisSong < playlist.count-1 && audioStuffed == true {
            thisSong += 1
            playCurrentSong()
        }
        
    }
    
    func previous() {
        
        if thisSong != 0 && audioStuffed == true {
            thisSong -= 1
            playCurrentSong()
        }
        
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func pause() {
        audioPlayer.pause()
    }
    
    func isPlaying() -> Bool {
        return audioPlayer.isPlaying
    }
    
    func getCurrentSongInfo() -> Music? {
        
        if !playlist.isEmpty {
            return playlist[thisSong]
        }
        return nil
        
    }
    
}
