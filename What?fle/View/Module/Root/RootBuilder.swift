//
//  RootBuilder.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs

// MARK: - Component

protocol RootDependency: Dependency {
    var networkService: NetworkServiceDelegate { get }
    var supabaseService: SupabaseServiceDelegate { get }
}

final class RootComponent: Component<RootDependency> {}

extension RootComponent: HomeDependency, AddDependency, MapDependency, LoginDependency {
    var networkService: NetworkServiceDelegate {
        return dependency.networkService
    }

    var supabaseService: SupabaseServiceDelegate {
        return dependency.supabaseService
    }

    var homeBuilder: HomeBuildable {
        return HomeBuilder(dependency: self)
    }

    var addBuilder: AddBuildable {
        return AddBuilder(dependency: self)
    }

    var mapBuilder: MapBuildable {
        return MapBuilder(dependency: self)
    }
    
    var loginBuilder: LoginBuildable {
        return LoginBuilder(dependency: self)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
