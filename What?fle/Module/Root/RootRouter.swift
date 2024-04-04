//
//  RootRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, HomeListener, MapListener, AddListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func setTabBarViewController(_ viewControllers: [UINavigationController], animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    private let component: RootComponent
    private weak var currentChild: ViewableRouting?
    private var addNavigationController: UINavigationController?

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

        let dummyNavigation = UINavigationController()
        dummyNavigation.tabBarItem = tabBarItem(type: .add)

        let mapRouter = component.mapBuilder.build(withListener: interactor)
        let mapNavigation = UINavigationController(root: mapRouter.viewControllable)
        mapNavigation.tabBarItem = tabBarItem(type: .map)
        attachChild(mapRouter)

        let viewControllables = [homeNavigation, dummyNavigation, mapNavigation]
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
//        detachCurrentView(animated: false) {
            if self.currentChild == nil {
                let router = self.component.addBuilder.build(withListener: self.interactor)
//                let navigation = UINavigationController(root: router.viewControllable)
//                addNavigationController = navigation
//                router.viewControllable.uiviewController.hidesBottomBarWhenPushed = true
                self.viewController.present(router.navigationController, animated: false)
                self.attachChild(router)
                self.currentChild = router
            }
//        }
    }

    func routeToSelectLocation() {
//        detachCurrentView(animated: false) {
//            if self.currentChild == nil {
//                let router = self.component.selectLocationBuilder.build(withListener: self.interactor)
//                let navigation = UINavigationController(root: router.viewControllable)
//                self.viewController.present(navigation, animated: true)
//                self.attachChild(router)
//                self.currentChild = router
//            }
//        }
    }

//    if self.currentChild == nil {
//        let addRouter = self.component.addBuilder.build(withListener: self.interactor)
//        let addNavigation = UINavigationController(root: addRouter.viewControllable)
//        self.viewController.present(addNavigation, animated: false)
//        self.attachChild(addRouter)
//        self.currentChild = addRouter
//    }

    func routeToRegistLocation() {
        if let child = self.currentChild {
            self.detachChild(child)
            self.currentChild = nil
        }

        if self.currentChild == nil {
//            let router = self.component.registLocatiionBuilder.build(withListener: self.interactor)
//            self.addNavigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
//            self.attachChild(router)
//            self.currentChild = router
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
