//
//  CharactersViewController+SearchBar.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 31/03/2023.
//

import Foundation
import UIKit

// MARK: - UISearchBarDelegate
extension CharactersViewController: UISearchBarDelegate {
    
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
            self.presenter.getCharacters()
        } else {
            self.presenter.getFilteredCharacters(name: searchText)
        }
    }
    
    // refresh table when you pressed cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
        self.presenter.getCharacters()
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
    }
}
