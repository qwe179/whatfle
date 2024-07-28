//
//  LoginBuilder.swift
//  What?fle
//
//  Created by 23 09 on 7/2/24.
//

import RIBs
import UIKit

protocol LoginDependency: Dependency {
    var networkService: NetworkServiceDelegate { get }
    var supabaseService: SupabaseServiceDelegate { get }
}

final class LoginComponent: Component<LoginDependency>, LoginDependency, ProfileSettingDependency {
    var loginBuilder: LoginBuildable {
        return LoginBuilder(dependency: self)
    }

    var profileSettingBuilder: ProfileSettingBuildable {
        return ProfileSettingBuilder(dependency: self)
    }

    var networkService: NetworkServiceDelegate {
        return dependency.networkService
    }

    var supabaseService: SupabaseServiceDelegate {
        return dependency.supabaseService
    }

}

// MARK: - Builder

protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener) -> LoginRouting
}

final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    deinit {
        print("\(self) is being deinit")
    }

    func build(withListener listener: LoginListener) -> LoginRouting {
        let component = LoginComponent(dependency: dependency)
        let viewController = LoginViewController()
        let interactor = LoginInteractor(presenter: viewController, networkService: component.networkService, supabaseService: component.supabaseService)
        interactor.listener = listener
        viewController.listener = interactor
        return LoginRouter(
            interactor: interactor,
            viewController: viewController,
            component: component
        )
    }
}
