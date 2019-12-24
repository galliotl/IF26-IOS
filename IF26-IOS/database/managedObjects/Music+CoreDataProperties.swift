//
//  Music+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 23/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension Music {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Music> {
        return NSFetchRequest<Music>(entityName: "Music")
    }

    @NSManaged public var mid: String?
    @NSManaged public var path: String?
    @NSManaged public var picPath: String?
    @NSManaged public var title: String?
    @NSManaged public var artist: User?
    @NSManaged public var favs: NSSet?

}

// MARK: Generated accessors for favs
extension Music {

    @objc(addFavsObject:)
    @NSManaged public func addToFavs(_ value: Favourite)

    @objc(removeFavsObject:)
    @NSManaged public func removeFromFavs(_ value: Favourite)

    @objc(addFavs:)
    @NSManaged public func addToFavs(_ values: NSSet)

    @objc(removeFavs:)
    @NSManaged public func removeFromFavs(_ values: NSSet)

}
