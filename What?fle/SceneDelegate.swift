//
//  SceneDelegate.swift
//  What?fle
//
//  Created by 이정환 on 2/22/24.
//

import UIKit

import RIBs

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var launchRouter: LaunchRouting?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                let window = UIWindow(windowScene: windowScene)
        self.window = window

        let component = AppComponent()
        let builder = RootBuilder(dependency: component)
        let launchRouter = builder.build()
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
