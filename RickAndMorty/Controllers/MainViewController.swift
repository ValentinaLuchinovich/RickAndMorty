//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    private var filtredCharacters:[Character] = []
    var results: [Character] = []
    
    let networkDataFetcher = NetworkDataFetcher()
    var charactersResponse: RickAndMorty?
    lazy var footerView = FooterView()
    private var galleryCollectionView = TopCollectionView()
    
    var urlRickMorty = "https://rickandmortyapi.com/api/character?page="
    let cellID = "cell"
    
    // searchController
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    // Отслеживает строку поиска
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(galleryCollectionView)
        setupOfViews()
        
        tableView.tableFooterView = footerView
        tableView.rowHeight = 80
        reloadCharacters()
    }
    
    func setupOfViews() {
        
        // TableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // CollectionView
        
        galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        galleryCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(TopCollectionView.collectionViewHigt)).isActive = true
        
        // Search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func reloadCharacters() {
        networkDataFetcher.fetchTracks(viewController: self, urlString: urlRickMorty) { (charactersResponse) in
            guard let charactersResponse = charactersResponse else { return }
            self.footerView.showLoader()
            self.charactersResponse = charactersResponse
            self.results.append(contentsOf: charactersResponse.results)
            
            self.tableView.reloadData()
            self.galleryCollectionView.set(result: self.results)
            self.galleryCollectionView.reloadData()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.urlRickMorty = charactersResponse?.info.next ?? ""
        if  self.urlRickMorty == "" {
            self.footerView.stopLoader()
        }
        reloadCharacters()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredCharacters.count
        } else {
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        var character: Character
        if isFiltering {
            character = filtredCharacters[indexPath.row]
        } else {
            character = results[indexPath.row]
        }
        
        cell.nameLabel.text = character.name
        cell.genderLabel.text = character.gender
        cell.speciesLabel.text = character.species
        cell.photoImage.kf.setImage(with: URL(string: character.image))
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result: Character
        if isFiltering {
            result = filtredCharacters[indexPath.row]
        } else {
            result = results[indexPath.row]
        }
        performSegue(withIdentifier: "detailVC", sender: result)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "detailVC", let result = sender as? Character, let vc =   segue.destination as? DetailViewController else { return }
        vc.result = result
    }
    
}

    // MARK: - Search

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filtredCharacters = results.filter({ (character: Character) -> Bool  in
            return character.name.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }
}


