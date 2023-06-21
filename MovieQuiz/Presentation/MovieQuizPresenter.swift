//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 21.06.2023.
//

import UIKit

final class MovieQuizPresenter: QuestionFactoryDelegate {
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    
    func didLoadDataFromServer() {
            viewController?.indicatorIsHidden()
            questionFactory?.requestNextQuestion()
        }
        
        func didFailToLoadData(with error: Error) {
            let message = error.localizedDescription
            viewController?.showNetworkError(message: message)
        }
        
        
    
    
    
    var questionFactory: QuestionFactoryProtocol?
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    var currentQuestion: QuizQuestion?
    private weak var viewController: MovieQuizViewController?
    var correctAnswers = 0
    
    
    init(viewController: MovieQuizViewController) {
            self.viewController = viewController
            
            questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
            questionFactory?.loadData()
            viewController.showLoadingIndicator()
        }
    
    
    
    /*
    func didLoadDataFromServer() {
        viewController?.indicatorIsHidden()
        questionFactory?.requestNextQuestion()
        viewController?.clearBorder()
        
    }
     */
    /*
    func didFailToLoadData(with error: Error) {
        viewController?.showNetworkError(message: error.localizedDescription)
    }
    
    */
    
    
    
    
    
    
    
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
            questionFactory?.requestNextQuestion()
            
        }
        
        func switchToNextQuestion() {
            currentQuestionIndex += 1
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
    
    
    
    
    
    
    

}
