//
//  Service.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//

import Foundation

enum PlistKeys {
    static let baseURL = "Base URL"
    static let apiKey = "API key"
}

public enum Service {
    
    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dictionary
    }()
    
    static let baseURL: String = {
        guard let baseURLString = Service.infoDictionary[PlistKeys.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
//        guard let url = URL(string: baseURLString) else {
//            fatalError("Invalid Base URL")
//        }
        return baseURLString
    }()
    
    static let apiKey: String = {
        guard let apiKey = Service.infoDictionary[PlistKeys.apiKey] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
//        guard let url = URL(string: baseURLString) else {
//            fatalError("Invalid Base URL")
//        }
        return apiKey
    }()
}
