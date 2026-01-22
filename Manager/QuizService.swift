//
//  Config.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//
import Foundation
import SwiftUI


//MARK: JSON BUNDLE CONFIG

enum QuizLevel: String, Codable{
    case iosJunior = "IOS-Junior"
    case iosMid = "IOS-Mid"
    case iosSenior = "IOS-Senior"
         
}
struct QuizService{
    
    static let shared = QuizService()
    
    func loadData(for level: QuizLevel) throws-> [Quiz]{
        guard let url = Bundle.main.url(forResource: level.rawValue, withExtension: "json") else {
            throw ConfigErrors.noData
        }
        
        do{
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Quiz].self, from: data)
            
            
        }catch let error as DecodingError{
            throw ConfigErrors.decodingFailed(error: error)
            
        }catch{
            throw ConfigErrors.loadingFailed(error: error)
        }
        
    }
}
