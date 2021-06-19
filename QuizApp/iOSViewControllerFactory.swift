//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Kalil Holanda on 13/06/21.
//

import UIKit
import QuizEngine

final class iOSViewControllerFactory: ViewControllerFactory {
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    private let correctAnswers: [Question<String>: [String]]
    
    init(questions: [Question<String>], options: [Question<String>: [String]], correctAnswers: [Question<String>: [String]]) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
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
                return questionViewController(for: question, value: value, options: option, allowsMultipleSelection: false, answerCallback: answerCallback)
                
            case .multipleAnswer(let value):
                return questionViewController(for: question, value: value, options: option, allowsMultipleSelection: true, answerCallback: answerCallback)
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String], allowsMultipleSelection: Bool, answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallback)
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let controller = ResultsViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
        controller.title = presenter.title
        return controller
    }
}
