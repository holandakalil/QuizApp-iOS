//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Kalil Holanda on 12/06/21.
//

@testable import QuizEngine

extension Result: Hashable {
    static func make(answer: [Question: Answer] = [:], score: Int = 0) -> Result {
        return Result(answer: answer, score: score)
    }
    
    public var hashValue: Int {
        return 1
    }
    
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
