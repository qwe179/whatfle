//
//  EditSelectedCollectionData.swift
//  What?fle
//
//  Created by 이정환 on 5/2/24.
//

import Foundation

struct EditSelectedCollectionData {
    let registeredLocations: [(String, [PlaceRegistration])]
    let selectedLocations: [(IndexPath, PlaceRegistration)]

//    var allLocationsIndexPaths: [IndexPath] {
//        var indexPaths = [IndexPath]()
//        for (sectionIndex, registeredLocation) in registeredLocations {
//            for rowIndex in 0..<registeredLocation.count {
//                indexPaths.append(IndexPath(row: rowIndex, section: sectionIndex))
//            }
//        }
//        return indexPaths
//    }
}
