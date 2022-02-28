//
//  ADOPApi.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//

import Alamofire

enum APODapi {
    case getAPODDetails
    
    var path: String {
        switch self {
        case .getAPODDetails:
            return "/planetary/apod"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAPODDetails:
            return .get
        }
    }
}
