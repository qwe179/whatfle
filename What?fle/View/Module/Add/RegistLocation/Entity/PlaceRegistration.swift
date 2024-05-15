//
//  PlaceRegistration.swift
//  What?fle
//
//  Created by 이정환 on 5/10/24.
//

import UIKit

struct PlaceRegistration {
    var accountID: Int
    var description: String
    var visitDate: String
    var placeName: String
    var address: String
    var roadAddress: String
    var images: [UIImage]
    var imageUrls: [String]?
    var latitude: Double
    var longitude: Double

    init(
        accountID: Int,
        description: String,
        visitDate: String,
        placeName: String,
        address: String,
        roadAddress: String,
        images: [UIImage],
        imageUrls: [String]? = nil,
        latitude: Double,
        longitude: Double
    ) {
        self.accountID = accountID
        self.description = description
        self.visitDate = visitDate
        self.placeName = placeName
        self.address = address
        self.roadAddress = roadAddress
        self.images = images
        self.imageUrls = imageUrls
        self.latitude = latitude
        self.longitude = longitude
    }

    init(imageUrls: [String], registration: PlaceRegistration) {
        self.accountID = registration.accountID
        self.description = registration.description
        self.visitDate = registration.visitDate
        self.placeName = registration.placeName
        self.address = registration.address
        self.roadAddress = registration.roadAddress
        self.images = registration.images
        self.imageUrls = imageUrls
        self.latitude = registration.latitude
        self.longitude = registration.longitude
    }
}
