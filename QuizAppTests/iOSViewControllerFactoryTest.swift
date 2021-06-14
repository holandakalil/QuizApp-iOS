//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 13/06/21.
//

import UIKit
import XCTest
@testable import QuizApp

final class iOSViewControllerFactoryTest: XCTestCase {
    let options = ["A1", "A2"]
    
    // MARK: Single Answer
    func test_questionViewController_singleAnswer_createsController() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController(question: Question.singleAnswer("Q1"))
        _ = controller.view
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: Multiple Answer
    func test_questionViewController_multipleAnswer_createsController() {
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController(question: Question.multipleAnswer("Q1"))
        _ = controller.view
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: - Helper
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
    }
}
