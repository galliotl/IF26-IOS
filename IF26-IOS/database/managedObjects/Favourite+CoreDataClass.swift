//
//  Favourite+CoreDataClass.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 25/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Favourite)
public class Favourite: NSManagedObject {
    
    func containsMusic(music: Music) -> Bool {
        return self.music!.mid == music.mid
    }
    
    static func fetchFavFromMusicAndUser(music: Music, user: User) -> NSFetchRequest<Favourite> {
        
        let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        fetchRequest.predicate = NSPredicate(format: "music == %@ AND artist == %@", music, user)
        return fetchRequest
        
    }
    
}
