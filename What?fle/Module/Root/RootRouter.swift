//
//  RootRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, HomeListener, MapListener, AddListener, RegistrationLocationListener, SelectLocationListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func setTabBarViewController(_ viewControllers: [UINavigationController], animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    private let component: RootComponent
    private weak var currentChild: ViewableRouting?

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        component: RootComponent
    ) {
        self.component = component
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        self.attachChildRIBs()
    }

    func attachChildRIBs() {
        let homeRouter = component.homeBuilder.build(withListener: interactor)
        let homeNavigation = UINavigationController(root: homeRouter.viewControllable)
        homeNavigation.tabBarItem = tabBarItem(type: .home)
        attachChild(homeRouter)

        let addNavigation = UINavigationController()
        addNavigation.tabBarItem = tabBarItem(type: .add)

        let mapRouter = component.mapBuilder.build(withListener: interactor)
        let mapNavigation = UINavigationController(root: mapRouter.viewControllable)
        mapNavigation.tabBarItem = tabBarItem(type: .map)
        attachChild(mapRouter)

        let viewControllables = [homeNavigation, addNavigation, mapNavigation]
        viewController.setTabBarViewController(viewControllables, animated: false)
    }
}

extension RootRouter {
    private func tabBarItem(type: ItemType) -> UITabBarItem {
        return .init(title: type.tatile, image: type.defaultImage, selectedImage: type.selectedImage)
    }
}

extension RootRouter: RootRouting {
    func routeToAddList() {
        detachCurrentView(animated: false) {
            if self.currentChild == nil {
                let router = self.component.addBuilder.build(withListener: self.interactor)
                self.viewController.present(router.viewControllable, animated: false)
                self.attachChild(router)
                self.currentChild = router
            }
        }
    }

    func routeToSelectLocation() {
        detachCurrentView(animated: false) {
            if self.currentChild == nil {
                let router = self.component.selectLocationBuilder.build(withListener: self.interactor)
                self.viewController.present(router.viewControllable, animated: true)
                self.attachChild(router)
                self.currentChild = router
            }
        }
    }

    func routeToRegistLocation() {
        self.viewController.uiviewController.dismiss(animated: true) {
            if let child = self.currentChild {
                self.detachChild(child)
                self.currentChild = nil
            }
        }
    }

    func detachCurrentView(animated: Bool, completion: (() -> Void)? = nil) {
        self.viewController.uiviewController.dismiss(animated: animated) { [weak self] in
            guard let self = self else { return }
            if let child = self.currentChild {
                self.detachChild(child)
                self.currentChild = nil
            }
            completion?()
        }
    }
}

// MARK: - enum ItemType
extension RootRouter {
    private enum ItemType: CaseIterable {
        case home, add, map

        var tatile: String {
            switch self {
            case .home:
                return "홈"
            case .add:
                return "추가"
            case .map:
                return "지도"
            }
        }

        var defaultImage: UIImage {
            switch self {
            case .home:
                return .homeLine
            case .add:
                return .addLine
            case .map:
                return .mappinLine
            }
        }

        var selectedImage: UIImage {
            switch self {
            case .home:
                return .homeFilled
            case .add:
                return .addFilled
            case .map:
                return .mappinFilled
            }
        }
    }
}
