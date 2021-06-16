//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 06/06/21.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

final class NavigationControllerRouterTest: XCTestCase {
    
    let singleQuestion1 = Question.singleAnswer("Q1")
    let singleQuestion2 = Question.singleAnswer("Q2")
    let multipleQuestion1 = Question.multipleAnswer("Q1")
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut = NavigationControllerRouter(navigationController, factory: factory)
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(singleQuestion1, with: viewController)
        factory.stub(singleQuestion2, with: secondViewController)
        
        sut.routeTo(question: singleQuestion1, answerCallback: { _ in })
        sut.routeTo(question: singleQuestion2, answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: singleQuestion1, answerCallback: { _ in callbackWasFired = true })
        
        factory.answerCallback[singleQuestion1]!([""])
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressToNextQuestion() {
        var callbackWasFired = false
        sut.routeTo(question: multipleQuestion1, answerCallback: { _ in callbackWasFired = true })
        
        factory.answerCallback[multipleQuestion1]!([""])
        
        XCTAssertFalse(callbackWasFired)
    }
    
    func test_routeToQuestion_singleAnswer_doesNotConfigurViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(singleQuestion1, with: viewController)
        sut.routeTo(question: singleQuestion1, answerCallback: { _ in  })
        
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(multipleQuestion1, with: viewController)
        sut.routeTo(question: multipleQuestion1, answerCallback: { _ in  })
        
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswerSubmitButton_isDisabledWhenNoAnswerSelected() {
        let viewController = UIViewController()
        factory.stub(multipleQuestion1, with: viewController)
        sut.routeTo(question: multipleQuestion1, answerCallback: { _ in  })
        
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleQuestion1]!([""])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleQuestion1]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
        let viewController = UIViewController()
        var callbackWasFired = false
        factory.stub(multipleQuestion1, with: viewController)
        sut.routeTo(question: multipleQuestion1, answerCallback: { _ in callbackWasFired = true })
        
        factory.answerCallback[multipleQuestion1]!([""])
        viewController.navigationItem.rightBarButtonItem?.simulateTap()
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToResult_showResultController() {
        let viewController = UIViewController()
        let result = Result.make(answer: [singleQuestion1: ["A1"]], score: 10)
        
        let secondViewController = UIViewController()
        let secondResult = Result.make(answer: [singleQuestion2: ["A2"]], score: 20)
        
        factory.stub(result, with: viewController)
        factory.stub(secondResult, with: secondViewController)

        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    // MARK: - Helpers
    
    final class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    final class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [Result<Question<String>, [String]>: UIViewController]()
        var answerCallback = [Question<String>: ([String]) -> Void]()
        
        func stub(_ question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(_ result: Result<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
