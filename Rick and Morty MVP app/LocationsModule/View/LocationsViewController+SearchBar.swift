//
//  LocationsViewController+SearchBar.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import Foundation
import UIKit

// MARK: - UISearchBarDelegate
extension LocationsViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        self.searchController.delegate = self
        self.searchController.showsCancelButton = true
        self.searchController.showsSearchResultsButton = false
        
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    // use this method to update(filter) table when you type the text and refresh when delete all of symbols
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.presenter.getLocations()
        } else {
            self.presenter.getFilteredLocations(name: searchText)
        }
    }
    
    // refresh table when you pressed cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
        self.presenter.getLocations()
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
    }
}

