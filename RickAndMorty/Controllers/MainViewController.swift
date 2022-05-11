//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let networkDataFetcher = NetworkDataFetcher()
    var charactersResponse: RickAndMorty?
    lazy var footerView = FooterView()
    var results: [Character] = []
    private var galleryCollectionView = TopCollectionView()
    
    var urlRickMorty = "https://rickandmortyapi.com/api/character?page="
    let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = footerView
        tableView.rowHeight = 80
        
        reloadCharacters()
        
//        view.addSubview(galleryCollectionView)
//        addTopCollectionView()
    }
    
    func addTopCollectionView() {
        
  
        // Расставляем боковые констрейнты для CollectionView
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//         Располагаем верхнюю границу на 10 точек ниже нижжней границе заголовка
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        // Располагаем нижнюю границу в 40 точках от края вью
//        galleryCollectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -40).isActive = true
        
//        // Устанавливам высоту CollectionView
        galleryCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        //Вызываем функцию наполняющую массив информацией о путешествиях
//        galleryCollectionView.set(cells: reloadCharacters())
    }
    
    func reloadCharacters() {
        networkDataFetcher.fetchTracks(viewController: self, urlString: urlRickMorty) { (charactersResponse) in
            guard let charactersResponse = charactersResponse else { return }
            self.footerView.showLoader()
            self.charactersResponse = charactersResponse
            self.results.append(contentsOf: charactersResponse.results)
            self.tableView.reloadData()
        }
    }
    

    

   
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        let character = results[indexPath.row]
        cell.nameLabel.text = character.name
        cell.genderLabel.text = character.gender
        cell.speciesLabel.text = character.species
        cell.photoImage.kf.setImage(with: URL(string: character.image))
        return cell
        }
    
    
    // MARK: - Table view delegate
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        performSegue(withIdentifier: "detailVC", sender: result)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "detailVC", let result = sender as? Character, let vc =   segue.destination as? DetailViewController else { return }
       vc.result = result
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.urlRickMorty = charactersResponse?.info.next ?? ""
        if  self.urlRickMorty == "" {
            self.footerView.stopLoader()
        }
        reloadCharacters()
    }
}
