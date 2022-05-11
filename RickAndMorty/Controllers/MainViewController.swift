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
    static var results: [Character] = []
    private var galleryCollectionView = TopCollectionView()
    
     var urlRickMorty = "https://rickandmortyapi.com/api/character?page="
    let cellID = "cell"
    
    
//    let view1: UIView = {
//        let view = UIView()
//        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(galleryCollectionView)
        
//        view.addSubview(view1)
        
        
        
        setupTopCollectionView()
        
        tableView.tableFooterView = footerView
        tableView.rowHeight = 80
//
        reloadCharacters()
        
     
 
    }
    
    func setupTopCollectionView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        galleryCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        view1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
//        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant:  50).isActive = true
//        galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
//        galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//      galleryCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 150).isActive = true
        
        
        
//        galleryCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
  
//        // Расставляем боковые констрейнты для CollectionView
//        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
////         Располагаем верхнюю границу на 10 точек ниже нижжней границе заголовка
//        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//        // Располагаем нижнюю границу в 40 точках от края вью
//        galleryCollectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -40).isActive = true
//
////        // Устанавливам высоту CollectionView
  
//        galleryCollectionView.heightAnchor.constraint(equalToConstant: view.heightAnchor, constant: 150).isActive = true
//
//        //Вызываем функцию наполняющую массив информацией о путешествиях
////        galleryCollectionView.set(cells: reloadCharacters())
    }
    
    func reloadCharacters() {
        networkDataFetcher.fetchTracks(viewController: self, urlString: urlRickMorty) { (charactersResponse) in
            guard let charactersResponse = charactersResponse else { return }
            self.footerView.showLoader()
            self.charactersResponse = charactersResponse
            MainViewController.results.append(contentsOf: charactersResponse.results)
//            galleryCollectionView.set(result: MainViewController.results)
            self.tableView.reloadData()
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
        return MainViewController.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        let character = MainViewController.results[indexPath.row]
        cell.nameLabel.text = character.name
        cell.genderLabel.text = character.gender
        cell.speciesLabel.text = character.species
        cell.photoImage.kf.setImage(with: URL(string: character.image))
        return cell
        }
    
    
    // MARK: - Table view delegate
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = MainViewController.results[indexPath.row]
        performSegue(withIdentifier: "detailVC", sender: result)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "detailVC", let result = sender as? Character, let vc =   segue.destination as? DetailViewController else { return }
       vc.result = result
    }
    
}
