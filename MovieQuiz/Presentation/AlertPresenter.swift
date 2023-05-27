//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 18.05.2023.
//

import UIKit
protocol AlertPresenter: {
    func show(alertModel: AlertModel)
    }


final class AlertPresenter: AlertPresenterImpl {
    
}

extension AlertPresenterImpl: AlertPresenter {
    func show(alertModel:AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.text,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
        
            alertModel.buttonAction()
            self.currentQuestionIndex = 0
            self.correctAnswer = 0
            self.questionFactory?.requestNextQuestion()
        
    }
    
}





/*
 {
    private weak var viewController:UIViewController?
    
    init(viewController: UIViewController? ) {
        self.viewController = viewController
    }
    func show(whit model: AlertModel) {
        let alert = UIAlertController(title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
*/
