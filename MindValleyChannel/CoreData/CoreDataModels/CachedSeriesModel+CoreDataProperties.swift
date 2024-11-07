//
//  CachedSeriesModel+CoreDataProperties.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 08/11/2024.
//
//

import Foundation
import CoreData


extension CachedSeriesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedSeriesModel> {
        return NSFetchRequest<CachedSeriesModel>(entityName: "CachedSeriesModel")
    }

    @NSManaged public var title: String
    @NSManaged public var coverAssetUrl: String

}

extension CachedSeriesModel : Identifiable {

}
