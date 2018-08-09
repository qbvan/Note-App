//
//  Entity+CoreDataProperties.swift
//  coreMana
//
//  Created by popCorn on 2018/08/08.
//  Copyright © 2018 popCorn. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var image: NSData?

}
