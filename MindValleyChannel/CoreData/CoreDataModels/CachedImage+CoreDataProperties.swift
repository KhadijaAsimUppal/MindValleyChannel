//
//  CachedImage+CoreDataProperties.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 06/11/2024.
//
//

import Foundation
import CoreData


extension CachedImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedImage> {
        return NSFetchRequest<CachedImage>(entityName: "CachedImage")
    }

    @NSManaged public var url: String
    @NSManaged public var data: Data

}

extension CachedImage : Identifiable {

}
