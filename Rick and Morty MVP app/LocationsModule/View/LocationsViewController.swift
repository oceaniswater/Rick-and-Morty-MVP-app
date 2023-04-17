//
//  LocationsViewController.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import UIKit
import SnapKit

class LocationsViewController: UIViewController {

    var presenter: LocationsViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        setupView()
    }

    // MARK: - Private properties
    let searchController: UISearchBar = {
        let search = UISearchBar()
        search.barTintColor = K.Design.appBackgroundColor
        search.tintColor = K.Design.appTextColor
        return search
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = K.Design.appBackgroundColor
        table.separatorStyle = .none
        return table
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .green
        return indicator
    }()

}

// MARK: - Setup constraints

private extension LocationsViewController {
    func setupView() {
        title = "Locations"
        view.backgroundColor = K.Design.appBackgroundColor
        
        view.addSubview(searchController)
        searchController.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchController.snp.bottom)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(tableView.snp.center)
        }
    }

}

// MARK: - LocationsViewProtocol

extension LocationsViewController: LocationsViewProtocol {
    func startActivity() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopActivity() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func success() {
        reloadTableView()
    }
    
    func failure(error: NetworkError) {
        print(error.localizedDescription)
    }
    
    
}

