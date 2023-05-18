//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 18.05.2023.
//

import UIKit

struct AlertModel {
    let title:String
    let message:String
    let buttonText:String
    let completion: (() -> Void)
}
