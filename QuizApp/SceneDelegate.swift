//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Kalil Holanda on 10/04/21.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let question1 = Question.singleAnswer("Where is the city of Santorini?")
        let question2 = Question.multipleAnswer("Which of these countries are in south america?")
        let questions = [question1, question2]
        
        let option1 = "Italy"
        let option2 = "France"
        let option3 = "Greece"
        let options1 = [option1, option2, option3]
        
        let option4 = "Brazil"
        let option5 = "France"
        let option6 = "Argentina"
        let option7 = "Italy"
        let option8 = "Greece"
        let options2 = [option4, option5, option6, option7, option8]
        
        let correctAnswers = [question1: [option3], question2: [option4, option6]]
        
        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(questions: questions, options: [question1: options1, question2: options2], correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
    }
}

