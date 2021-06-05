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
        
        let vc = ResultsViewController(summary: "You got 1/2 questions correct.", answers: [
            PresentableAnswer(question: "Question 1? Question 1? Question 1? Question 1? Question 1? Question 1? Question 1? Question 1? ", answer: "Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! ", wrongAnswer: nil),
            PresentableAnswer(question: "Question 2?", answer: "Hell yeah!", wrongAnswer: "Nope..")
        ])
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

