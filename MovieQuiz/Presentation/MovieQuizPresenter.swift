//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 21.06.2023.
//

import UIKit

final class MovieQuizPresenter {
    
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?
    var questionFactory: QuestionFactoryProtocol?
    var correctAnswers = 0
    
    
    func yesButtonClicked() {
        didAnswer(isYes: true)
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = isYes
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        viewController?.buttonsAreBlocked()
        
    }
    
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        
    }
    
    
    func isLastQuestion() -> Bool {
            currentQuestionIndex == questionsAmount - 1
        }
        
        func restartGame() {
            currentQuestionIndex = 0
            correctAnswers = 0
            
        }
        
        func switchToNextQuestion() {
            currentQuestionIndex += 1
        }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
            self?.viewController?.buttonsAreActive()
            
        }
        
    }
    
    func showNextQuestionOrResults() {
        viewController?.indicatorIsHidden()
        if isLastQuestion() {
            viewController?.showFinalResults()
            viewController?.clearBorder()
            viewController?.buttonsAreActive()
            
        } else {
            
            switchToNextQuestion()
            questionFactory?.requestNextQuestion()
            viewController?.clearBorder()
            viewController?.buttonsAreActive()
        }
    }
    
    func didAnswer(isCorrectAnswer: Bool){
        correctAnswers += 1
        
    }
    
    
    
    
    
    
    
   /* func yesButtonClicked() {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = true
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        viewController?.buttonsAreBlocked()
        
    }
    
    func noButtonClicked() {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = false
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        viewController?.buttonsAreBlocked()
    }
    */

}