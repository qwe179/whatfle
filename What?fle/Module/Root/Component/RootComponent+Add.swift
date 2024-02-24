//
//  RootComponent+Add.swift
//  What?fle
//
//  Created by 이정환 on 2/25/24.
//

import RIBs

extension RootComponent: AddDependency {
    var addBuilder: AddBuildable {
        return AddBuilder(dependency: self)
    }
}

