//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 22.05.2023.
//

import UIKit

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: BestGame? { get }
    
    func store(correct: Int, total: Int)
}

final class StatisticServiceImpl {
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let dateProvider: () -> Date
    
    init(
userDefaults: UserDefaults = .standard,
decoder: JSONDecoder = JSONDecoder(),
encoder: JSONEncoder = JSONEncoder(),
dateProvider: @escaping () -> Date = { Date()}
    ) {
        self.userDefaults = userDefaults
        self.decoder = decoder
        self.encoder = encoder
        self.dateProvider = dateProvider
    }
}
    
extension StatisticServiceImpl: StatisticService {
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    
    
    var bestGame: BestGame? {
        get {
            guard
                let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let bestGame = try? decoder.decode(BestGame.self, from: data) else {
                return nil
            }
            return bestGame
        }
        set {
            let data = try? encoder.encode(newValue)
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
        
    }
    
    var totalAccuracy: Double {
        Double(correct) / Double(total) * 100
    }
    
    func store(correct: Int, total: Int) {
        self.correct += correct
        self.total += total
        self.gamesCount += 1
        
        let date = dateProvider()
        let currentBestGame = BestGame(correct: correct, total: total, date: date)
        if let previousBestGame = bestGame {
            if currentBestGame > previousBestGame {
                bestGame = currentBestGame
            }
        } else {
            bestGame = currentBestGame
        }
    }
}


    





/*
 
 
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
            //UserDefaults.standard.set(newValue, forKey: Keys.total.rawValue)
        }
         set {
            UserDefaults.standard.set(newValue, forKey: Keys.total.rawValue)
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


 */
