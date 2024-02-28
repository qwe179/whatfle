//
//  RootComponent + Search.swift
//  What?fle
//
//  Created by 이정환 on 3/20/24.
//

import Foundation

extension RootComponent: SelectLocationDependency {
    var selectLocationBuilder: SelectLocationBuildable {
        return SelectLocationBuilder(dependency: self)
    }
}
