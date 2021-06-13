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
        switch question {
            case .singleAnswer(let value):
                return QuestionViewController(question: value, options: options[question]!, selection: answerCallback)
            default:
                return UIViewController()
        }
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
