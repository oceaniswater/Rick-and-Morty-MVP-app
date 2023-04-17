//
//  LocationDetailViewController+CollectionView.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import Foundation
import UIKit

extension LocationDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        self.residentsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.residentsCollectionView.delegate = self
        self.residentsCollectionView.dataSource = self
        
        registerCell()
    }
    
    func registerCell() {
        self.residentsCollectionView.register(ResidentCollectionViewCell.self, forCellWithReuseIdentifier: ResidentCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.numberOfItemsInSection(in: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter.numberOfSection()

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResidentCollectionViewCell.identifier, for: indexPath) as! ResidentCollectionViewCell
        if let resident = presenter.residents[indexPath.row] {
            cell.configure(with: resident)
        }
        return cell
    }
    
    
}

extension LocationDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
