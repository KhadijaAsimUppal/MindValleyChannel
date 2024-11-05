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
