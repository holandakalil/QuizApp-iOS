//
//  QuestionViewController.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 10/04/21.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_ViewDidLoad_rendersQuestionHeaderText() {
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_ViewDidLoad_WithNoOptions_rendersWithZeroOtions() {
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_ViewDidLoad_WithOneOptions_rendersWithOneOtions() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_ViewDidLoad_WithOneOptions_rendersOneOtionText() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        _ = sut.view
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}
