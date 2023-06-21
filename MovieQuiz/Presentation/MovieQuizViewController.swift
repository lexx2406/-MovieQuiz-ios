import UIKit

final class MovieQuizViewController: UIViewController {

    private var gamesCount = 0
    private var statisticService: StatisticService?
    private var alertPresenter: AlertPresenter?
    private var presenter: MovieQuizPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        textLabel.font = UIFont(name: "YSDisplay-Bold", size: 23)
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        labelQuestion.font = UIFont(name: "YSDisplay-Medium", size: 20)
        imageView.layer.cornerRadius = 20
        showLoadingIndicator()
        alertPresenter = AlertPresenterImpl(viewController: self)
        statisticService = StatisticServiceImpl()
        presenter = MovieQuizPresenter(viewController: self)
        
    }
    

    
    
    
    @IBOutlet weak private var noButton: UIButton!
    @IBOutlet weak private var yesButton: UIButton!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = presenter.currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        noButton.isEnabled = false
        yesButton.isEnabled = false
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.currentQuestion = presenter.currentQuestion
        presenter.yesButtonClicked()
    }
    
    @IBOutlet weak private var labelQuestion: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    
    
   func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    
   func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            presenter.didAnswer(isCorrectAnswer: isCorrect)
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ysGreen.cgColor : UIColor.ysRed.cgColor
        imageView.layer.cornerRadius = 20
        activityIndicator.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.presenter.showNextQuestionOrResults()
        }
    }
    
    
    func showFinalResults(){
        statisticService?.store(correct: presenter.correctAnswers, total: presenter.questionsAmount)
        let alertModel = AlertModel(
            title: "Этот раунд окончен!",
            message: makeResultMessage(),
            buttonText: "Сыграть ещё раз",
            buttonAction: { [weak self] in
                self?.presenter.restartGame()
                self?.presenter.questionFactory?.requestNextQuestion()
            }
        )
        alertPresenter?.show(alertModel: alertModel)
    }
    
    private func makeResultMessage() -> String {
        guard let statisticService = statisticService, let bestGame = statisticService.bestGame else {
            assertionFailure("error message")
            return ""
        }
        
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(presenter.correctAnswers)/\(presenter.questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)/\(bestGame.total) (\(bestGame.date.dateTimeString))"
        let averageAccuracyLine = "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%"
        let resultMessage = [currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, averageAccuracyLine].joined(separator: "\n")
        return resultMessage
    }
    
    
   func showNetworkError(message: String) {
        activityIndicator.isHidden = true
        
        let alertModel = AlertModel(title: "Ошибка",
                                    message: message,
                                    buttonText: "Попробовать еще раз",
                                    buttonAction: { [weak self] in
            guard let self = self else { return }
           
            
            self.presenter.restartGame()
            self.presenter.questionFactory?.loadData()
            
            
            
        }
        )
        
        alertPresenter?.show(alertModel: alertModel)
    }
    
    
    func buttonsAreBlocked() {
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    
    func buttonsAreActive() {
        noButton.isEnabled = true
        yesButton.isEnabled = true
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func indicatorIsHidden() {
        activityIndicator.isHidden = true
    }
    
    func clearBorder() {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.borderWidth = 0
        
    }

}




