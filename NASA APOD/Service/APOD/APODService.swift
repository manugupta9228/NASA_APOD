//
//  APODService.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//
import Alamofire
import Foundation

class APODService {
    
    func apiToGetAPOD(date: String, completion : @escaping (APODModel.GET.Response?, AFError?) -> ()){
        guard let url = URL(string: "\(Service.baseURL)\(APODapi.getAPODDetails.path)") else {
            return
        }
        
        let parameters = ["api_key": Service.apiKey,
                          "date": date]
        let request = AF.request(url,
                                 method: APODapi.getAPODDetails.method,
                                 parameters: parameters)
        request.responseDecodable(of: APODModel.GET.Response.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            completion(response.value, nil)
        }
    }
}
