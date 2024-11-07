//
//  CachedCategoryModel+CoreDataProperties.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 08/11/2024.
//
//

import Foundation
import CoreData


extension CachedCategoryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedCategoryModel> {
        return NSFetchRequest<CachedCategoryModel>(entityName: "CachedCategoryModel")
    }

    @NSManaged public var name: String?

}

extension CachedCategoryModel : Identifiable {

}
