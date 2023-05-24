//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 22.05.2023.
//

import UIKit

private var totalAccuracy = 0.00

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    
}
    
func resultCount() -> Int {
    var count = UserDefaults.standard.integer(forKey:"gamesCount") + 1
    UserDefaults.standard.set(count, forKey: "gamesCount")
    return count
}

    
    func totalAccuracyСalculation(answers:Int,questions:Int,count:Int ) -> Double {
        
        if count == 1 {
            totalAccuracy = (Double(answers))/(Double(questions))*100
            
        } else {
            totalAccuracy = (((Double(answers))/(Double(questions))*100) + (UserDefaults.standard.double(forKey:"Accuracy")) * Double(count - 1))/((Double(count)))
                    
        }
                                     
    UserDefaults.standard.set(totalAccuracy, forKey: "Accuracy")
                                     
    return totalAccuracy
    
}
    
var bestGame: GameRecord { get }

final class StatisticServiceImplementation: StatisticService {
    
    func store(correct count: Int, total amount: Int) {
        userDefaults.set(Any?, forKey: String)
    }
    private let userDefaults = UserDefaults.standard
    
    var totalAccuracy: Double
    
    var gamesCount: Int
    
    var bestGame: GameRecord
    
    internal init(totalAccuracy: Double, gamesCount: Int, bestGame: GameRecord) {
        self.totalAccuracy = totalAccuracy
        self.gamesCount = gamesCount
        self.bestGame = bestGame
    }
}

struct GameRecord: Codable, Comparable {
    let correct: Int
    let total: Int
    let date: Date
    static func < (lhs: GameRecord, rhs: GameRecord) -> Bool {
        if lhs.correct < rhs.correct {
            let lhs = rhs
        }
    }
     
     }
     
