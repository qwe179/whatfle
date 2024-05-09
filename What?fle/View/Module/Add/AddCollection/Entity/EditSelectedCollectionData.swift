//
//  EditSelectedCollectionData.swift
//  What?fle
//
//  Created by 이정환 on 5/2/24.
//

import Foundation

struct EditSelectedCollectionData {
    let registeredLocations: [RegisteredLocation]
    let selectedLocations: [(IndexPath, KakaoSearchDocumentsModel)]

    var allLocationsIndexPaths: [IndexPath] {
        var indexPaths = [IndexPath]()
        for (sectionIndex, registeredLocation) in registeredLocations.enumerated() {
            for rowIndex in 0..<registeredLocation.locations.count {
                indexPaths.append(IndexPath(row: rowIndex, section: sectionIndex))
            }
        }
        return indexPaths
    }
}
