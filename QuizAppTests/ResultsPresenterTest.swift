//
//  ResultsPresenterTest.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 14/06/21.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

final class ResultsPresenterTest: XCTestCase {
    
    // MARK: Summary
    func test_summary_withTwoQuestionAndScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q2"): ["A2", "A3"]]
        let result = Result.make(answer: answers, score: 1)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_shouldBeEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    // MARK: Single Answer
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    // MARK: Multiple Answer
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
}
