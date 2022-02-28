//
//  APODFavouriteViewController.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 27/02/22.
//

import AlamofireImage
import CoreData
import UIKit

class APODFavouriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var context: NSManagedObjectContext!
    
    private var persistentContainer: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not convert delegate to AppDelegate")
        }
        return appDelegate.persistentContainer
    }
    
    
    lazy var fetchedResultsController:
    NSFetchedResultsController<APODFavourite> = {

        let fetchRequest: NSFetchRequest<APODFavourite> = APODFavourite.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"date", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "APODFavouriteTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: APODFavouriteTableViewCell.reuseIdentifier)
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension APODFavouriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APODFavouriteTableViewCell.reuseIdentifier, for: indexPath) as? APODFavouriteTableViewCell else { fatalError("Unexpected Index Path") }
        
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let apodFavItem = fetchedResultsController.object(at: indexPath)
        if let cell = cell as? APODFavouriteTableViewCell {
            cell.dateLabelView.text = apodFavItem.date
            cell.titleLabelView.text = apodFavItem.title
            cell.explanationLabelView.text = apodFavItem.explanation
            if let url = apodFavItem.url, let imageUrl = URL(string: url) {
                cell.apodFavImageView.af.setImage(withURL: imageUrl)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complete in
            if let record = self?.fetchedResultsController.object(at: indexPath as IndexPath) {
                self?.persistentContainer.viewContext.delete(record)
            }
            complete(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension APODFavouriteViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller:
                                     NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller:
                    NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
                configureCell(cell, at: indexPath)
            }
        case .move:
            if let newIndexPath = newIndexPath, let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
        }
    }
    
    func controllerDidChangeContent(_ controller:
                                    NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
