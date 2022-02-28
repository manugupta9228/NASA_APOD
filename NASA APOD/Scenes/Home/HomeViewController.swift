//
//  HomeViewController.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        dateTextField.text = Utility.getTodayStringDate()
        dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
            if let datePicker = dateTextField.inputView as? UIDatePicker {
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                self.dateTextField.text = dateformatter.string(from: datePicker.date)
            }
            self.dateTextField.resignFirstResponder()
        }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "APOD", bundle: Bundle.main)
        if let apodViewController = storyBoard.instantiateViewController(withIdentifier: "APODViewController") as? APODViewController {
            apodViewController.viewModel = APODViewModel(date: dateTextField.text)
            self.navigationController?.pushViewController(apodViewController, animated: true)
        }
    }
    
    @IBAction func showFavButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "APODFavourite", bundle: Bundle.main)
        if let apodFavouriteViewController = storyBoard.instantiateViewController(withIdentifier: "APODFavouriteViewController") as? APODFavouriteViewController {
            self.navigationController?.pushViewController(apodFavouriteViewController, animated: true)
        }
    }
}
