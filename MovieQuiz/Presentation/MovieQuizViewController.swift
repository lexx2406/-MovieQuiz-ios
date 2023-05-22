import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
    private var alertPresenter: AlertPresenterProtokol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        textLabel.font = UIFont(name: "YSDisplay-Bold", size: 23)
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        labelQuestion.font = UIFont(name: "YSDisplay-Medium", size: 20)
        imageView.layer.cornerRadius = 20
        questionFactory = QuestionFactory(delegate: self)
        
        questionFactory?.requestNextQuestion()
        alertPresenter = AlertPresenter(viewController: self)
        
        
        /*
         var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "inception.json"
        documentsURL.appendPathComponent(fileName)
        _ = try? String(contentsOf: documentsURL)
        
        struct Actor: Codable {
            let id: String
            let image: String
            let name: String
            let asCharacter: String
        }
        struct Movie: Codable {
            let id: String
            let title: String
            let year: String
            let image: String
            let releaseDate: String
            let runtimeMins: String
            let directors: String
            let actorList: [Actor]
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
            }
            enum CodingKeys: CodingKey {
               case id, title, year, image, releaseDate, runtimeMins, directors, actorList
             }
        }
        
        func jsonObject(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
            do {
                _ = try JSONDecoder().decode(Movie.self, from: data)
            } catch {
                print("Failed to parse: \(error.localizedDescription)")
            }
        }
        
        let movieData = try JSONEncoder().encode(movie)
        */
    
        /*
         class func jsonObject(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let data = jsonString.data(using: .utf8) else {
                return
            }            let title = json?["title"]
            let year = json?["year"]
            print(json)
            let actorList = json?["actorList"] as? [Any]
            {
                print(actor["asCharacter"])
            }
        }
    } catch {
        print("Failed to parse: \(jsonString)")
    }

    struct Actor {
        let id: String
        let image: String
        let name: String
        let asCharacter: String
    }
    struct Movie {
        let id: String
        let title: String
        let year: Int
        let image: String
        let releaseDate: String
        let runtimeMins: Int
        let directors: String
        let actorList: [Actor]
    }
    
    
    func getMovie(from jsonString: String) -> Movie? {
        var movie:Movie? = nil
        
        do {
            guard let data = jsonString.data(using: .utf8) else {
                return
            }
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let json = json,
                  let id = json ["id"] as? String,
                  let title = json ["title"] as? String,
                  let year = json ["year"] as? String,
                  let image = json ["image"] as? String,
                  let releaseDate = json ["releaseDate"] as? String,
                  let runtimeMins = json Int["runtimeMins"] as?,
                  let directors = json ["directors"] as? String,
                  let actorList = json ["actorList"] as? Any, else
            {
                  return nil
                }
            movie = Movie(
                id: String,
                title: String,
                year: Int,
                image: String,
                releaseDate: String,
                runtimeMins: Int,
                directors: String,
                actorList: [Actor])
            
        } catch {
            
            print("Failed to parse: \(jsonString)")
            
        }
    }
    
        return movie
    }
         */

}
    
   /*
    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    */
    
    /*
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
     */
    
  /*  private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        
    }
    
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            let text = correctAnswers == questionsAmount ?
                    "Поздравляем, Вы ответили на 10 из 10!" :
                    "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз!"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
            imageView.layer.borderColor = nil
            noButton.isEnabled = true
            yesButton.isEnabled = true
        } else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
            imageView.layer.borderColor = nil
            noButton.isEnabled = true
            yesButton.isEnabled = true
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText,
            completion: {[weak self] in
                guard let self else {return}
                self.imageView.layer.borderColor = nil
                self.noButton.isEnabled = true
                self.yesButton.isEnabled = true
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                self.questionFactory?.requestNextQuestion()
            }
            )
            alertPresenter?.show(whit: alertModel )
    }
            
            

    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ysGreen.cgColor : UIColor.ysRed.cgColor
        imageView.layer.cornerRadius = 20
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
   */
    
    @IBOutlet weak private var noButton: UIButton!
    @IBOutlet weak private var yesButton: UIButton!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    @IBAction private func noButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        noButton.isEnabled = false
        yesButton.isEnabled = false
    }
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    
    @IBOutlet weak private var labelQuestion: UILabel!
    
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            let text = correctAnswers == questionsAmount ?
                    "Поздравляем, Вы ответили на 10 из 10!" :
                    "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз!"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
            imageView.layer.borderColor = nil
            noButton.isEnabled = true
            yesButton.isEnabled = true
        } else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
            imageView.layer.borderColor = nil
            noButton.isEnabled = true
            yesButton.isEnabled = true
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText,
            completion: {[weak self] in
                guard let self else {return}
                self.imageView.layer.borderColor = nil
                self.noButton.isEnabled = true
                self.yesButton.isEnabled = true
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                self.questionFactory?.requestNextQuestion()
            }
            )
            alertPresenter?.show(whit: alertModel )
    }
            
            

    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ysGreen.cgColor : UIColor.ysRed.cgColor
        imageView.layer.cornerRadius = 20
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    
    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
}







