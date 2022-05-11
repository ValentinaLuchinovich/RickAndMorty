//
//  TopCollectionView.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 11.05.2022.
//

import UIKit

class TopCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var results: [Character] = []
    
    // Создаем инициализатор, который будет содердать фрейм и макет CollectionView
    init() {
        let layout = UICollectionViewFlowLayout()
        // Выбираем горизонтальный скролл ячеек
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        delegate = self
        dataSource = self
        
        // Регистрируем ячейку созданную в GallaryCollectionViewCell
        register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.reuseID)
        
        // При ручном изменении констрейтов данное свойство должно быть обозначено в false, иначе элементы отображаться не будут
        translatesAutoresizingMaskIntoConstraints = false
        
        // Задаем расстояние между ячеками
        layout.minimumLineSpacing = 20
        // Задаем констрейты для ячейки
        contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.reuseID, for: indexPath) as! TopCollectionViewCell
        
        let character = results[indexPath.row]
        cell.photoImageView.kf.setImage(with: URL(string: character.image))
        // Добавляем в ячейку изображение
//        cell.mainimageView.image = cells[indexPath.row].mainImage
//        // Добавляем в ячеку заголовок
//        cell.nameLabel.text = cells[indexPath.row].locationName
//        // Добавляем в ячеку описание
//        cell.descriptionOfTravel.text = cells[indexPath.row].description
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}