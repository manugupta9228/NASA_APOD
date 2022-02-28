//
//  APODFavouriteTableViewCell.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 27/02/22.
//

import UIKit

class APODFavouriteTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var apodFavImageView: UIImageView!
    @IBOutlet weak var dateLabelView: UILabel!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var explanationLabelView: UILabel!
    
    // MARK: - Properties
    static let reuseIdentifier = "APODFavouriteTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
