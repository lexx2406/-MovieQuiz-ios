//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 18.05.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
