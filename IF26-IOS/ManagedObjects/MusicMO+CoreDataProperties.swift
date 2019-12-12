//
//  MusicMO+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 12/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension MusicMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicMO> {
        return NSFetchRequest<MusicMO>(entityName: "Music")
    }

    @NSManaged public var mid: String?
    @NSManaged public var path: String?
    @NSManaged public var picPath: String?
    @NSManaged public var title: String?
    @NSManaged public var artistId: UserMO?
    @NSManaged public var favs: NSSet?

}

// MARK: Generated accessors for favs
extension MusicMO {

    @objc(addFavsObject:)
    @NSManaged public func addToFavs(_ value: FavouriteMO)

    @objc(removeFavsObject:)
    @NSManaged public func removeFromFavs(_ value: FavouriteMO)

    @objc(addFavs:)
    @NSManaged public func addToFavs(_ values: NSSet)

    @objc(removeFavs:)
    @NSManaged public func removeFromFavs(_ values: NSSet)

}
