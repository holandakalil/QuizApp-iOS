//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Kalil Holanda on 10/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let vc = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"]) {
            print($0)
        }
        _ = vc.view
        vc.tableView.allowsMultipleSelection = true
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

