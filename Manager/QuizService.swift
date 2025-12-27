//
//  Config.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//
import Foundation
import SwiftUI


//MARK: JSON BUNDLE CONFIG
protocol QuizService{
    func loadData() throws-> [Quiz]
}

struct BundleService: QuizService{
    
    func loadData() throws-> [Quiz]{
        guard let url = Bundle.main.url(forResource: "QuizQuestions", withExtension: "json") else {
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
