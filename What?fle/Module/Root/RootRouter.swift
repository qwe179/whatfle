//
//  RootRouter.swift
//  What?fle
//
//  Created by 이정환 on 2/23/24.
//

import UIKit

import RIBs

protocol RootInteractable: Interactable, HomeListener, AddListener, MapListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func setTabBarViewController(_ viewControllers: [ViewControllable], animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let component: RootComponent

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
        homeRouter.viewControllable.uiviewController.tabBarItem = tabBarItem(type: .home)
        attachChild(homeRouter)

        let addRouter = component.addBuilder.build(withListener: interactor)
        addRouter.viewControllable.uiviewController.tabBarItem = tabBarItem(type: .add)
        attachChild(addRouter)

        let mapRouter = component.mapBuilder.build(withListener: interactor)
        mapRouter.viewControllable.uiviewController.tabBarItem = tabBarItem(type: .map)
        attachChild(mapRouter)

        let viewControllables = [homeRouter.viewControllable, addRouter.viewControllable, mapRouter.viewControllable]
        viewController.setTabBarViewController(viewControllables, animated: false)
    }
}

extension RootRouter {
    private func tabBarItem(type: ItemType) -> UITabBarItem {
        return .init(title: type.tatile, image: type.defaultImage, selectedImage: type.selectedImage)
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
