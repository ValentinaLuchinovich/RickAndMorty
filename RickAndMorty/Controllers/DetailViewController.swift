//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var result: Character?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImage.kf.setImage(with: URL(string: result?.image ?? ""))
        nameLabel.text = result?.name
        statusLabel.text = result?.status
        genderLabel.text = result?.gender
        speciesLabel.text = result?.species
        locationLabel.text = result?.location.name
        episodeLabel.text = "Episodes: " + String(result?.episode.count ?? 0)
        
    }
}
