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
    
    func removeMusicFromDb(mid: String) -> Bool {
        
        let request: NSFetchRequest<Music> = Music.fetchRequest()
        request.predicate = NSPredicate(format: "mid == %@", mid)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result: [Music] = try moc.fetch(request)
            if result.isEmpty {
                return false
            }
            let music = result[0]
            moc.delete(music)
            try moc.save()
            return true
            
        } catch {
            
            // peut être besoin de rajoutter l'élément ici
            print("cannot delete music")
            return false
            
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
