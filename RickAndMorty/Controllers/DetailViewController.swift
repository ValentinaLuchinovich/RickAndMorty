//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    let cell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
