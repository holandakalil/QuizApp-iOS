//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 12/06/21.
//

@testable import QuizEngine

extension Result {
    static func make(answer: [Question: Answer] = [:], score: Int = 0) -> Result {
        return Result(answer: answer, score: score)
    }
}

extension Result: Equatable where Answer: Equatable {
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answer == rhs.answer
    }
}

extension Result: Hashable where Answer: Equatable {
    public var hashValue: Int {
        return 1
    }
}
