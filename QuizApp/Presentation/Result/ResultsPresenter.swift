//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Kalil Holanda on 14/06/21.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let result: Result<Question<String>, [String]>
    let questions: [Question<String>]
    let correctAnswers: [Question<String>: [String]]
    
    var title: String {
        return "Result"
    }
    
    var summary: String {
        return "You got \(result.score)/\(result.answer.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return questions.map{ question in
            guard let userAnswer = result.answer[question], let correctAnswer = correctAnswers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            return presentableAnswer(question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
            case .singleAnswer(let value), .multipleAnswer(let value):
                return PresentableAnswer(question: value,
                                         answer: formattedAnswer(correctAnswer),
                                         wrongAnswer: formattedWrongAnswer(correctAnswer, userAnswer))
        }
    }
    
    private func formattedWrongAnswer(_ correctAnswer: [String], _ userAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
}
