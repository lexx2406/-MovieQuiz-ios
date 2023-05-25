//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 22.05.2023.
//

import UIKit


protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}

struct GameRecord: Codable, Comparable {
    static func < (lhs: GameRecord, rhs: GameRecord) -> Bool {
        <#code#>
    }
   let correct: Int
   let total: Int
   let date: Date
}

final class StatisticServiceImplementation: StatisticService {
    
    func store(correct count: Int, total amount: Int) {
    }
    var totalAccuracy: Double {
        get {UserDefaults.standard.double(forKey: Keys.gamesCount.rawValue),
            statisticService?.totalAccuracy ?? 0.0}
    }
    
    
    var gamesCount: Int { get { UserDefaults.standard.integer(forKey: "gamesCount") } set { UserDefaults.set.integer(forKey: Keys.gamesCount.rawValue) } }
        
        UserDefaults.standard.integer(forKey: Keys.gamesCount.rawValue)
    }
    var bestGame: GameRecord {
        get {
            guard let data = UserDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            UserDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
}
/*
 func resultCount() -> Int {
    let count = UserDefaults.standard.integer(forKey:"gamesCount") + 1
    //count = 0 //для обнуления раскоментировать строку
    UserDefaults.standard.set(count, forKey: "gamesCount")
    return count
}

     func totalAccuracyСalculation(answers:Int,questions:Int,count:Int ) -> String {
        
        if count == 1 {
            totalAccuracy = (Double(answers))/(Double(questions))*100
            
        } else {
            totalAccuracy = (((Double(answers))/(Double(questions))*100) + (UserDefaults.standard.double(forKey:"Accuracy")) * Double(count - 1))/((Double(count)))
                    
        }
        //totalAccuracy = 0 //для обнуления раскоментировать строку
    UserDefaults.standard.set(totalAccuracy, forKey: "Accuracy")
                                     
        return String(format: "%.2f", totalAccuracy)
    
}
    */
