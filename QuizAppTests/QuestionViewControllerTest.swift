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
    
    // MARK: Helper
    func makeSUT(question: String = "", options: [String] = []) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options)
        _ = sut.view
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: 0)
        return self.dataSource?.tableView(self, cellForRowAt: indexPath)
    }
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
