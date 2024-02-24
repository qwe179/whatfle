//
//  RootComponent+Map.swift
//  What?fle
//
//  Created by 이정환 on 2/25/24.
//

import RIBs

extension RootComponent: MapDependency {
    var mapBuilder: MapBuildable {
        return MapBuilder(dependency: self)
    }
}

