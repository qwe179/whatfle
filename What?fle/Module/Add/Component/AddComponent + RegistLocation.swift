//
//  AddComponent + RegistLocation.swift
//  What?fle
//
//  Created by 이정환 on 3/26/24.
//

import RIBs

extension AddComponent: RegistLocationDependency {
    var registLocatiionBuilder: RegistLocationBuildable {
        return RegistLocationBuilder(dependency: self)
    }
}
