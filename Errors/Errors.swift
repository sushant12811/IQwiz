//
//  Errors.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2025-12-19.
//
import Foundation

//MARK: ERROR: Custom Config Errors
enum ConfigErrors: Error {
    case noData
    case loadingFailed(error : Error)
    case decodingFailed(error : Error)
    
    var description: String?{
        switch self {
        case .noData:
            "Error no data or file found"
        case .loadingFailed(let error):
            "Error: Loading failed with error: \(error.localizedDescription)"
        case .decodingFailed(let error):
            "Error: Decoding failed with error: \(error.localizedDescription)"
        }
        
    }
}
