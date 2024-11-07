//
//  CachedChannelModel+CoreDataProperties.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 08/11/2024.
//
//

import Foundation
import CoreData


extension CachedChannelModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedChannelModel> {
        return NSFetchRequest<CachedChannelModel>(entityName: "CachedChannelModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var mediaCount: Int32
    @NSManaged public var iconAssetUrl: String?
    @NSManaged public var coverAsseturl: String?
    @NSManaged public var series: NSSet?
    @NSManaged public var courses: NSSet?

}

// MARK: Generated accessors for series
extension CachedChannelModel {

    @objc(addSeriesObject:)
    @NSManaged public func addToSeries(_ value: CachedSeriesModel)

    @objc(removeSeriesObject:)
    @NSManaged public func removeFromSeries(_ value: CachedSeriesModel)

    @objc(addSeries:)
    @NSManaged public func addToSeries(_ values: NSSet)

    @objc(removeSeries:)
    @NSManaged public func removeFromSeries(_ values: NSSet)

}

// MARK: Generated accessors for courses
extension CachedChannelModel {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: CachedCourseModel)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: CachedCourseModel)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}

extension CachedChannelModel : Identifiable {

}
