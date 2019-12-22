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
        music.mid = UUID()
        music.path = path
        music.title = title
        music.artistId = artist
        
        do {
            try moc.save()
            return true
        } catch {
            moc.delete(music)
            print("cannot add music to db")
            return false
        }
        
    }
    
    func removeMusicFromDb(mid: UUID) -> Bool {
        
        let request = NSFetchRequest<Music>(entityName: "Music")
        // request.predicate = NSPredicate(format: "mid == %@", mid)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result: [Music] = try moc.fetch(request)
            if result.isEmpty {
                return false
            }
            let music = result[0]
            try moc.delete(music)
            return true
            
        } catch {
            print("cannot delete music")
            return false
        }

    }
    
    func getMusics() -> [Music] {
       
        let request = NSFetchRequest<Music>(entityName: "Music")
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [Music] = try moc.fetch(request)
            return result
        } catch {
            print("cannot fetch the user")
            return []
        }
    
    }
    
}
