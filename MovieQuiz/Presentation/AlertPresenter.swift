//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 18.05.2023.
//

import UIKit
protocol AlertPresenterProtokol: AnyObject {
    func show(whit model: AlertModel)
    }


class AlertPresenter: AlertPresenterProtokol {
    private weak var viewController:UIViewController?
    
    init(viewController: UIViewController? ) {
        self.viewController = viewController
    }
    func show(whit model: AlertModel) {
        let allert = UIAlertController(title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}

