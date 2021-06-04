//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 10/04/21.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_ViewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_ViewDidLoad_rendersOtions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_ViewDidLoad_rendersOtionsText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receiveAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receiveAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receiveAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receiveAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callbackCount += 1 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelectionsEnabled_notifiesDelegateWithLastSelection() {
        var receiveAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receiveAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receiveAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receiveAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelectionsEnabled_notifiesDelegate() {
        var receiveAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receiveAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receiveAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receiveAnswer, [])
    }
    
    // MARK: Helper
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping ([String]) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}
