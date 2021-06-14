//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Kalil Holanda on 13/06/21.
//

import UIKit
import QuizEngine

final class iOSViewControllerFactory: ViewControllerFactory {
    private let options: [Question<String>: [String]]
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let option = options[question] else {
            fatalError("Couldn't find option for \(question)")
        }
        return questionViewController(for: question, option: option, answerCallback: answerCallback)
    }
    
    private func questionViewController(for question: Question<String>, option: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
            case .singleAnswer(let value):
                return QuestionViewController(question: value, options: option, selection: answerCallback)
                
            case .multipleAnswer(let value):
                let controller = QuestionViewController(question: value, options: option, selection: answerCallback)
                _ = controller.view
                controller.tableView.allowsMultipleSelection = true
                return controller
        }
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
