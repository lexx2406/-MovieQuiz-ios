//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 21.06.2023.
//

import UIKit

final class MovieQuizPresenter: QuestionFactoryDelegate {
   
    
    let statisticService: StatisticService!
    var questionFactory: QuestionFactoryProtocol?
    var currentQuestion: QuizQuestion?
    private weak var viewController: MovieQuizViewController?
    var correctAnswers = 0
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    
    
    init(viewController: MovieQuizViewController) {
        self.viewController = viewController
        statisticService = StatisticServiceImpl()
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
    
    
    
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
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        let message = error.localizedDescription
        viewController?.showNetworkError(message: message)
    }
    
    
    
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
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
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
        viewController?.hideLoadingIndicator()
        if isLastQuestion() {
            viewController?.makeResult()
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
    
    
    func makeResultMessage() -> String {
        guard let statisticService = statisticService, let bestGame = statisticService.bestGame else {
            assertionFailure("error message")
            return ""
        }
        
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(correctAnswers)/\(questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)/\(bestGame.total) (\(bestGame.date.dateTimeString))"
        let averageAccuracyLine = "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%"
        let resultMessage = [currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, averageAccuracyLine].joined(separator: "\n")
        return resultMessage
    }
    
    
    func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            didAnswer(isCorrectAnswer: isCorrect)
        }
        viewController?.highlightImageBorder(isCorrectAnswer: isCorrect)
        viewController?.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    init(viewController: MovieQuizViewControllerProtocol) {
            self.viewController = viewController as? MovieQuizViewController
            
            statisticService = StatisticServiceImpl()
            
            questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
            questionFactory?.loadData()
            viewController.showLoadingIndicator()
        }
    
    
}
