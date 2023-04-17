//
//  LocationDetailViewController.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import UIKit
import SnapKit

class LocationDetailViewController: UIViewController {
    
    var presenter: LocationDetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        presenter.setLocation()
    }
    
    
    // MARK: - Private properties
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "name:"
        return label
    }()
    
    private var nameValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private let typeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "type:"
        return label
    }()
    
    private var typeValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private let dimensionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "dimension:"
        return label
    }()
    
    private var dimensionValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private let residentsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "residents:"
        return label
    }()
    
    var residentsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
}

private extension LocationDetailViewController {
    func setupView() {
        view.backgroundColor = K.Design.appBackgroundColor
        
        view.addSubview(nameTitleLabel)
        nameTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        view.addSubview(nameValueLabel)
        nameValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTitleLabel.snp.bottom).inset(10)
        }
        
        view.addSubview(typeTitleLabel)
        typeTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameValueLabel.snp.bottom).inset(10)
        }
        
        view.addSubview(typeValueLabel)
        typeValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(typeTitleLabel.snp.bottom).inset(10)
        }
        
        view.addSubview(dimensionTitleLabel)
        dimensionTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(typeValueLabel.snp.bottom).inset(10)
        }
        
        view.addSubview(dimensionValueLabel)
        dimensionValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dimensionTitleLabel.snp.bottom).inset(10)
        }
        
        view.addSubview(residentsTitleLabel)
        residentsTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dimensionValueLabel.snp.bottom).inset(10)
        }
        
        view.addSubview(residentsCollectionView)
        residentsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(residentsTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(120)
        }
    }
}

extension LocationDetailViewController: LocationDetailViewProtocol {
    func setLocation(location: LocationResult?) {
        if let location = location {
            nameValueLabel.text = location.name
            typeValueLabel.text = location.type
            dimensionValueLabel.text = location.dimension
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.residentsCollectionView.reloadData()
        }
    }
    
    func failure(error: NetworkError) {
        
    }
    
    
}
