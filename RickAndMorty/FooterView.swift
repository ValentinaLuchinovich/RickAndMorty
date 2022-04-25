//
//  FooterView.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import Foundation
import UIKit

class FooterView: UIView {
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func stopLoader() {
        loader.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
