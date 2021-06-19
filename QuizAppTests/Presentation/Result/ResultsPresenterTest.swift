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
    
    let singleQuestion1 = Question.singleAnswer("Q1")
    let multipleQuestion1 = Question.multipleAnswer("Q1")
    let multipleQuestion2 = Question.multipleAnswer("Q2")
    
    func test_summary_rendersTitle() {
        let result: Result<Question<String>, [String]> = Result.make(answer: [:], score: 0)
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])
        
        XCTAssertEqual(sut.title, "Result")
    }
    
    func test_summary_withTwoQuestionAndScoreOne_returnsSummary() {
        let answers = [singleQuestion1: ["A1"], multipleQuestion2: ["A2", "A3"]]
        let result = Result.make(answer: answers, score: 1)
        let orderedQuestions = [singleQuestion1, multipleQuestion2]
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_shouldBeEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [singleQuestion1: ["A1"]]
        let correctAnswers = [singleQuestion1: ["A2"]]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [singleQuestion1], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [multipleQuestion1: ["A1", "A4"]]
        let correctAnswers = [multipleQuestion1: ["A2", "A3"]]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [multipleQuestion1], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withTwoQuestion_mapsOrderedAnswer() {
        let answers = [multipleQuestion2: ["A2"], multipleQuestion1: ["A1", "A4"]]
        let correctAnswers = [multipleQuestion2: ["A2"], multipleQuestion1: ["A1", "A4"]]
        let orderedQuestions = [multipleQuestion1, multipleQuestion2]
        let result = Result.make(answer: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A2")
        XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
    }
}
