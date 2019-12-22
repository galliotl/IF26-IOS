//
//  User+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 19/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var picPath: String?
    @NSManaged public var uid: String?
    @NSManaged public var favs: NSSet?
    @NSManaged public var musics: NSSet?

}

// MARK: Generated accessors for favs
extension User {

    @objc(addFavsObject:)
    @NSManaged public func addToFavs(_ value: Favourite)

    @objc(removeFavsObject:)
    @NSManaged public func removeFromFavs(_ value: Favourite)

    @objc(addFavs:)
    @NSManaged public func addToFavs(_ values: NSSet)

    @objc(removeFavs:)
    @NSManaged public func removeFromFavs(_ values: NSSet)

}

// MARK: Generated accessors for musics
extension User {

    @objc(addMusicsObject:)
    @NSManaged public func addToMusics(_ value: Music)

    @objc(removeMusicsObject:)
    @NSManaged public func removeFromMusics(_ value: Music)

    @objc(addMusics:)
    @NSManaged public func addToMusics(_ values: NSSet)

    @objc(removeMusics:)
    @NSManaged public func removeFromMusics(_ values: NSSet)

}
