//
//  TopCollectionView.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 11.05.2022.
//

import UIKit
import Kingfisher

class TopCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let collectionViewHigt = 150
    
    var results: [Character] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        self.register(UINib(nibName:"TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TopCollectionViewCell.reuseID)

        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constans.galleryMinimumLineSpasing
        contentInset = UIEdgeInsets(top: 10, left: Constans.leftDistanceToView, bottom: 10, right: Constans.leftDistanceToView)
    }
    
    func set(result: [Character]) {
        results.append(contentsOf: result)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.reuseID, for: indexPath) as! TopCollectionViewCell
        let character = results[indexPath.row]
        cell.photoImageView?.kf.setImage(with: URL(string: character.image))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(TopCollectionView.collectionViewHigt) - Constans.topDistanceToView - Constans.bottomDistanceToView, height: CGFloat(TopCollectionView.collectionViewHigt) - Constans.topDistanceToView - Constans.bottomDistanceToView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
