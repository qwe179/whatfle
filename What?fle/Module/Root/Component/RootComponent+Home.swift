//
//  RootComponent+TabBar.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

extension RootComponent: HomeDependency {
    var homeBuilder: HomeBuildable {
        return HomeBuilder(dependency: self)
    }
}
