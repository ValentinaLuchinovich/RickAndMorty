//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    var charactersResponse: RickAndMorty?
    lazy var footerView = FooterView()
    var urlRickMorty = "https://rickandmortyapi.com/api/character?page="
    let cellID = "cell"
    var result: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = footerView
        tableView.rowHeight = 80
        
        reloadCharacters()
    }
    
    func reloadCharacters() {
        networkDataFetcher.fetchTracks(viewController: self, urlString: urlRickMorty) { (charactersResponse) in
            
            guard let charactersResponse = charactersResponse else { return }
            self.footerView.showLoader()
            self.charactersResponse = charactersResponse
            self.result.append(contentsOf: charactersResponse.results)
            self.tableView.reloadData()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.urlRickMorty = charactersResponse?.info.next ?? ""
        if  self.urlRickMorty == "" {
            self.footerView.stopLoader()
        }
        
        reloadCharacters()
     

    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        
        let character = result[indexPath.row]
        cell.nameLabel.text = character.name
        cell.genderLabel.text = character.gender
        cell.speciesLabel.text = character.species
        cell.photoImage.kf.setImage(with: URL(string: character.image))
        return cell
        }
     
}
