//
//  APODModel.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//

import Foundation
import UIKit

struct APOD {
    struct DisplayModel {
        let screenTitle: String?
        let apodTitle: String?
        let isFavorite: Bool
        let apodExplanation: String?
        let apodImageUrl: String?
        let error: String?
        
        init(screenTitle: String? = nil,
             apodTitle: String? = nil,
             isFavorite: Bool = false,
             apodExplanation: String? = nil,
             apodImageUrl: String? = nil,
             error: String? = nil) {
            self.screenTitle = screenTitle
            self.apodTitle = apodTitle
            self.isFavorite = isFavorite
            self.apodExplanation = apodExplanation
            self.apodImageUrl = apodImageUrl
            self.error = error
        }
    }
}
