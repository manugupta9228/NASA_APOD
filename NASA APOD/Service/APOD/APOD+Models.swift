//
//  APOD.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//

import Foundation

struct APODModel {
    struct GET {
        struct Response: Codable {
            let date: String
            let explanation: String
            let hdUrl: String
            let mediaType: String
            let serviceVersion: String
            let title: String
            let url: String
            
            enum CodingKeys: String, CodingKey {
                case date, explanation
                case hdUrl = "hdurl"
                case mediaType = "media_type"
                case serviceVersion = "service_version"
                case title, url
            }
        }
    }
}
