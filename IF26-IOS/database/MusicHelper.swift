//
//  MusicHelper.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 19/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreData

class MusicHelper {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moc: NSManagedObjectContext
    
    init() {
        moc = appDelegate.coreDataStack.managedObjectContext
    }
    
    func addMusicToDb(title: String, path: String, artist: User) -> Bool {
        
        // create music
        let music = NSEntityDescription.insertNewObject(forEntityName: "Music", into: moc) as! Music
        music.mid = UUID().uuidString
        music.path = path
        music.title = title
        music.artist = artist
        
        do {
            try moc.save()
            return true
        } catch {
            moc.delete(music)
            print("cannot add music to db")
            return false
        }
        
    }
    
    func removeMusicFromDb(mid: String) {
        
        let request: NSFetchRequest<Music> = Music.fetchRequest()
        request.predicate = NSPredicate(format: "mid == %@", mid)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result: [Music] = try moc.fetch(request)
            if result.isEmpty {
                return
            }
            let music = result[0]
            moc.delete(music)
            try moc.save()
            
        } catch {
            print("cannot delete music")
        }

    }
    
    func switchFav(user: User, music: Music) -> Bool {
        
        if user.hasFaved(music: music) {
            removeFav(user: user, music: music)
            return false
        } else {
            addToFavs(user: user, music: music)
            return true
        }
        
    }
    
    func addToFavs(user: User, music: Music) {
        
        let favourite = NSEntityDescription.insertNewObject(forEntityName: "Favourite", into: moc) as! Favourite
        favourite.fid = UUID().uuidString
        favourite.artist = user
        favourite.music = music
        
        do {
            try moc.save()
            print("faved added")
        } catch {
            moc.delete(music)
            print("cannot add fav to db")
        }

    }
    
    func removeFav(user: User, music: Music) {
        
        let request = Favourite.fetchFavFromMusicAndUser(music: music, user: user)
        do {
            
            let result = try moc.fetch(request)
            let favourite = result[0]
            moc.delete(favourite)
            try moc.save()
            print("faved removed")
        } catch {
            print("couldn't remove the favourite item")
        }
        
    }
    
    func getMusics() -> [Music] {
       
        let request: NSFetchRequest<Music> = Music.fetchRequest()
        
        do {
            let result: [Music] = try moc.fetch(request)
            return result
        } catch {
            print("cannot fetch the user")
            return []
        }
    
    }
    
}
