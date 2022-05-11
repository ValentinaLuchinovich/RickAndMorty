//
//  TopCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 11.05.2022.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "TopCollectionViewCell"

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
