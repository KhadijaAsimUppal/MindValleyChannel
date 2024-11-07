//
//  CachedCourseModel+CoreDataProperties.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 08/11/2024.
//
//

import Foundation
import CoreData


extension CachedCourseModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedCourseModel> {
        return NSFetchRequest<CachedCourseModel>(entityName: "CachedCourseModel")
    }

    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var coverAssetModel: String?

}

extension CachedCourseModel : Identifiable {

}
