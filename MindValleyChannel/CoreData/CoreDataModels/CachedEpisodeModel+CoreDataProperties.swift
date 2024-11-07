//
//  CachedEpisodeModel+CoreDataProperties.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 06/11/2024.
//
//

import Foundation
import CoreData


extension CachedEpisodeModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedEpisodeModel> {
        return NSFetchRequest<CachedEpisodeModel>(entityName: "CachedEpisodeModel")
    }

    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var channelTitle: String
    @NSManaged public var coverAssetUrl: String

}

extension CachedEpisodeModel : Identifiable {

}
