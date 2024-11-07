//
//  Enums.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 05/11/2024.
//

enum ContentSection: Int, CaseIterable {
    case episodes = 0
    case channels
    case categories
    
    var title: String {
        switch self {
        case .episodes:
            return "New Episodes"
        case .channels:
            return "Channels"
        case .categories:
            return "Browse by Categories"
        }
    }
}

enum MediaDisplayable {
    case series(SeriesModel)
    case course(CourseModel)
    
    var title: String {
        switch self {
        case .series(let series):
            return series.title
        case .course(let course):
            return course.title
        }
    }
    
    var imageUrl: String {
        switch self {
        case .series(let series):
            return series.coverAsset.url
        case .course(let course):
            return course.coverAsset.url
        }
    }
}
