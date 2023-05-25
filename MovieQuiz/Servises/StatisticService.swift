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
        return lhs.correct < rhs.correct
    }
   let correct: Int
   let total: Int
   let date: Date
}

final class StatisticServiceImplementation: StatisticService {
    
   
    func store(correct count: Int, total amount: Int) {
    }
    
    

    var totalAccuracy: Double {
        get {
            //UserDefaults.standard.double(forKey: Keys.gamesCount.rawValue)
            let correctCount = UserDefaults.standard.integer(forKey: Keys.correct.rawValue)
            //(statisticService?.totalAccuracy ?? 0.0)
            //var correctCount = UserDefaults.standard.integer(forKey: Keys.correct.rawValue),
            //(statisticService?.totalAccuracy ?? 0.0)
            // UserDefaults.standard.double(forKey: Keys.gamesCount.rawValue)
            return (Double(correctCount)/Double(gamesCount))*100
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }

    
    var gamesCount: Int {
            get {
                UserDefaults.standard.integer(forKey: Keys.gamesCount.rawValue)
                
            }
            set {
                UserDefaults.standard.set(newValue, forKey: Keys.gamesCount.rawValue)
            }
        }
    
    var bestGame: GameRecord {
           get {
               guard let data = UserDefaults.standard.data(forKey: Keys.bestGame.rawValue),
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
               

               UserDefaults.standard.set(data, forKey: Keys.bestGame.rawValue)
           }
       }
       private enum Keys: String {
           case correct, total, bestGame, gamesCount
       }
   }


