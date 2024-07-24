//
//  HomeBuilder.swift
//  What?fle
//
//  Created by 이정환 on 2/24/24.
//

import RIBs

protocol HomeDependency: Dependency {
    var networkService: NetworkServiceDelegate { get }
    var supabaseService: SupabaseServiceDelegate { get }
}

final class HomeComponent: Component<HomeDependency>, LoginDependency {
    var loginBuilder: LoginBuildable {
        return LoginBuilder(dependency: self)
    }
    
    var networkService: NetworkServiceDelegate {
        return dependency.networkService
    }

    var supabaseService: SupabaseServiceDelegate {
        return SupabaseService()
    }
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener) -> HomeRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController, networkService: component.networkService, supabaseService: component.supabaseService)
        interactor.listener = listener
        return HomeRouter(interactor: interactor, viewController: viewController, component: component)
    }
}
