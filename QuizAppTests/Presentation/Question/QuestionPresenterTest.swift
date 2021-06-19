//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 14/06/21.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

final class QuestionPresenterTest: XCTestCase {
    
    let question1 = Question.singleAnswer("Q1")
    let question2 = Question.multipleAnswer("Q2")
    
    func test_title_forFirstQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1], question: question1)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistentQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [], question: Question.multipleAnswer("12345"))
        
        XCTAssertEqual(sut.title, "")
    }
}
