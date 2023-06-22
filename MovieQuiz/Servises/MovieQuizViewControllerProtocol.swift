//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 22.06.2023.
//

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func makeResult()
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
}
