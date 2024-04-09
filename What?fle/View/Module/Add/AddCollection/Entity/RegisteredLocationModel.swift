//
//  RegisteredLocationModel.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import Foundation

struct RegisteredLocationModel: Decodable {
    let totalCount: Int
    let registLocations: [RegisteredLocation]
}

struct RegisteredLocation: Decodable {
    let date: String
    let memo: String
    let locations: [KakaoSearchDocumentsModel]

    enum CodingKeys: String, CodingKey {
        case date
        case memo
        case locations
    }
}
