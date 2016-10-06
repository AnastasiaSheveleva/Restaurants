//
//  Restaurant+CoreDataProperties.swift
//  RestTV
//
//  Created by Анастасия on 04.10.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant");
    }

    @NSManaged public var adress: String
    @NSManaged public var image: NSData?
    @NSManaged public var isVisited: Bool
    @NSManaged public var name: String
    @NSManaged public var phone: String?
    @NSManaged public var rating: String?

}
