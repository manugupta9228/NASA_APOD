//
//  APODViewController.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 25/02/22.
//
import AlamofireImage
import UIKit

class APODViewController: UIViewController {
    
    @IBOutlet weak var apodImageView: UIImageView!
    @IBOutlet weak var apodTitleLabel: UILabel!
    @IBOutlet weak var apodExplanationLabel: UILabel!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var addToFavButtonHeightConstraint: NSLayoutConstraint!
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    var loadingView : ActivityIndicatorView!
    
    var viewModel: APODViewModel!
    
    var displayModel: APOD.DisplayModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        updateButtonStyle(false)
        setupActivityIndicator()
        activityIndicator.startAnimating()
        viewModel.getAPODdata()
    }
    
    func setupUI(_ displayModel: APOD.DisplayModel) {
        self.title = displayModel.screenTitle
        if let url = displayModel.apodImageUrl, let imageUrl = URL(string: url) {
            activityIndicator.stopAnimating()
            apodImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
        }
        apodTitleLabel.text = displayModel.apodTitle
        apodExplanationLabel.text = displayModel.apodExplanation
        updateButtonStyle(!displayModel.isFavorite)
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @IBAction func addToFavTapped(_ sender: UIButton) {
        viewModel.saveAsFavourite()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func updateButtonStyle(_ enabled: Bool) {
        if enabled {
            addToFavButton.isHidden = false
            addToFavButtonHeightConstraint.constant = 40
        } else {
            addToFavButton.isHidden = true
            addToFavButtonHeightConstraint.constant = 0
        }
    }
}

extension APODViewController: DisplayLogicDelegate {
    func updateView(displayModel: APOD.DisplayModel) {
        self.displayModel = displayModel
        self.setupUI(displayModel)
    }
    
    func addedAsFavourite() {
        guard let date = displayModel?.screenTitle else { return }
        let alert = UIAlertController(title: "Alert", message: "Your APOD \(date) is saved to Favourites", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: { [weak self] in
            self?.updateButtonStyle(false)
        })
    }
}
