//
//  LoginBuilder.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs

protocol LoginDependency: Dependency {
    var networkService: NetworkServiceDelegate { get }
    var supabaseService: SupabaseServiceDelegate { get }
}

final class LoginComponent: Component<EmptyComponent>, LoginDependency, TermsOfUseDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }

    var builder: LoginBuildable {
        return LoginBuilder(dependency: self)
    }

    var termsOfUseBuilder: TermsOfUseBuildable {
        return TermsOfUseBuilder(dependency: self)
    }

    var networkService: NetworkServiceDelegate {
        return NetworkService()
    }

    var supabaseService: SupabaseServiceDelegate {
        return SupabaseService()
    }

}

// MARK: - Builder

protocol LoginBuildable: Buildable {
    func build() -> LaunchRouting
}

final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = LoginComponent()
        let viewController = LoginViewController()
        let interactor = LoginInteractor(presenter: viewController, networkService: component.networkService, supabaseService: component.supabaseService)
        return LoginRouter(interactor: interactor, viewController: viewController, component: component)
    }
}
