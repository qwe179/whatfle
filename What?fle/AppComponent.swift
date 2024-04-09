//
//  AppComponent.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

class AppComponent: Component<EmptyComponent>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }

    var builder: RootBuildable {
        return RootBuilder(dependency: self)
    }

    var networkService: NetworkServiceDelegate {
        return NetworkService()
    }
}
