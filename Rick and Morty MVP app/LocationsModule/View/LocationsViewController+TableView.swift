//
//  LocationsViewController+TableView.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerCell()
    }
    
    func registerCell() {
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        
        guard let location = self.presenter.locations?[indexPath.row] else {
            return UITableViewCell() }
        cell.configure(with: location)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = presenter.locations?[indexPath.row]
        presenter.tapOnTheLocation(location: location)
    }
    
    
}
