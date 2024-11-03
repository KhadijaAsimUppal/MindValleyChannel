//
//  CategoriesModel.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

struct CategoriesModel: Codable {
    let data: CategoriesDataModel
}

struct CategoriesDataModel: Codable {
    let categories: [CategoryModel]
}

struct CategoryModel: Codable {
    let name: String
}
