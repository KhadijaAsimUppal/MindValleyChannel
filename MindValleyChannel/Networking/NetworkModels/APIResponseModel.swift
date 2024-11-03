//
//  Untitled.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

struct APIResponseModel<T: Decodable>: Decodable {
    let data: T
}
