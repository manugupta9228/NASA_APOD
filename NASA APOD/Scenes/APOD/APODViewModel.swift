//
//  APODViewModel.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//

import CoreData
import Foundation
import UIKit

protocol DisplayLogicDelegate: NSObject {
    func updateView(displayModel: APOD.DisplayModel)
    func addedAsFavourite()
}

class APODViewModel {
    
    typealias DisplayModel = APOD.DisplayModel
    typealias ApodApiResponse =  APODModel.GET.Response
    
    private var apodService : APODService!
    private var apodResponse: ApodApiResponse?
    private var apodDate: String?
    weak var delegate: DisplayLogicDelegate?
    
    private var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not convert delegate to AppDelegate")
        }
        return appDelegate
    }
    
    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    init(date: String?) {
        self.apodDate = date
        self.apodService = APODService()
    }
    
    func getAPODdata() {
        guard let date = apodDate, let datsString = Utility.convertDateToYYYYDDMMFormat(dateString: date) else { return }
        if let apodItem = checkIfAlreadyExist(date: datsString).1 {
            processCoreDataToDisplayData(item: apodItem)
        } else {
            self.apodService.apiToGetAPOD(date: datsString, completion: { [weak self] response, error in
                guard let response = response else {
                    self?.delegate?.updateView(displayModel: DisplayModel(error: "Error Text"))
                    return
                }
                self?.apodResponse = response
                self?.processDisplayData(response: response)
            })
        }
    }
    
    func processDisplayData(response: ApodApiResponse) {
        let displayModel = DisplayModel(screenTitle: apodDate,
                                         apodTitle: response.title,
                                         isFavorite: false,
                                         apodExplanation: response.explanation,
                                         apodImageUrl: response.url,
                                         error: nil)
        self.delegate?.updateView(displayModel: displayModel)
    }
    
    func processCoreDataToDisplayData(item: APODFavourite) {
        let displayModel = DisplayModel(screenTitle: apodDate,
                                         apodTitle: item.title,
                                         isFavorite: true,
                                         apodExplanation: item.explanation,
                                         apodImageUrl: item.url,
                                         error: nil)
        self.delegate?.updateView(displayModel: displayModel)
    }
    
    func saveAsFavourite() {
        if let apodResponse = apodResponse {
            let entity = NSEntityDescription.entity(forEntityName: "APODFavourite", in: self.context)
            let apodFavItem = NSManagedObject(entity: entity!, insertInto: self.context)
            
            // Mapping items to core data
            apodFavItem.setValue(apodResponse.date, forKey: "date")
            apodFavItem.setValue(apodResponse.explanation, forKey: "explanation")
            apodFavItem.setValue(apodResponse.hdUrl, forKey: "hdUrl")
            apodFavItem.setValue(apodResponse.title, forKey: "title")
            apodFavItem.setValue(apodResponse.url, forKey: "url")
            
            appDelegate.saveContext()
            delegate?.addedAsFavourite()
        }
    }
    
    func checkIfAlreadyExist(date: String) -> (Bool, APODFavourite?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return (false, nil) }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let fetchRequest : NSFetchRequest<APODFavourite> = APODFavourite.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "date == %@", date)
            let fetchedResults = try context.fetch(fetchRequest)
            if let apodItem = fetchedResults.first {
                return (true, apodItem)
            }
            return (false, nil)
        }
        catch {
            return (false, nil)
        }
    }
}
