//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Алексей Налимов on 31.05.2023.
//

import Foundation

struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: URL
    
    var resizedImageURL: URL {
            let urlString = imageURL.absoluteString
            let imageUrlString = urlString.components(separatedBy: "._")[0] + "._V0_UX600_.jpg"
            guard let newURL = URL(string: imageUrlString) else {
                return imageURL
            }
            
            return newURL
        }
    
    private enum CodingKeys: String, CodingKey {
        case title = "fullTitle"
        case rating = "imDbRating"
        case imageURL = "image"
    }
}





<<<<<<< HEAD




=======
>>>>>>> b1e2f92b6fa08e79ad68f23aceed538f939fd773
