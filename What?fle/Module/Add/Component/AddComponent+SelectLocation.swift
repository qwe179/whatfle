//
//  AddComponent+SelectLocation.swift
//  What?fle
//
//  Created by 이정환 on 2/27/24.
//

import RIBs

extension AddComponent: SelectLocationDependency {
    var selectLocationBuilder: SelectLocationBuildable {
        return SelectLocationBuilder(dependency: self)
    }
}
