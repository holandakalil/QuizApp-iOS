//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 13/06/21.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

final class iOSViewControllerFactoryTest: XCTestCase {
    let options = ["A1", "A2"]
    let singleQuestion = Question.singleAnswer("Q1")
    let multipleQuestion = Question.multipleAnswer("Q1")
    
    // MARK: Single Answer
    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let questions = [singleQuestion, multipleQuestion]
        let question = singleQuestion
        let presenter = QuestionPresenter(questions: questions, question: question)
        XCTAssertEqual(makeQuestionController(question: singleQuestion).title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createsController() {
        XCTAssertEqual(makeQuestionController(question: singleQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: singleQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController(question: singleQuestion)
        XCTAssertFalse(controller.allowsMultipleSelection)
    }
    
    // MARK: Multiple Answer
    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let questions = [singleQuestion, multipleQuestion]
        let question = multipleQuestion
        let presenter = QuestionPresenter(questions: questions, question: question)
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsController() {
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController(question: multipleQuestion)
        XCTAssertTrue(controller.allowsMultipleSelection)
    }
    
    func test_resultsViewController_createsControllerWithSummary() {
        let result = makeResults()
        XCTAssertEqual(result.controller.summary, result.presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswers() {
        let result = makeResults()
        XCTAssertEqual(result.controller.answers.count, result.presenter.presentableAnswers.count)
    }
    
    // MARK: - Helper
    func makeSUT(options: [Question<String>: [String]] = [:], correctAnswers: [Question<String>: [String]] = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleQuestion, multipleQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleQuestion: ["A1"], multipleQuestion: ["A1", "A2"]]
        let correctAnswers = [singleQuestion: ["A1"], multipleQuestion: ["A1", "A2"]]
        
        let result = Result.make(answer: userAnswers, score: 2)
        let questions = [singleQuestion, multipleQuestion]
        
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)
        
        let controller = sut.resultViewController(for: result) as! ResultsViewController
        
        return (controller, presenter)
    }
}
