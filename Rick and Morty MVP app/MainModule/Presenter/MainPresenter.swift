//
//  MainPresenter.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 28/03/2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol)
    func tapOnTheCharacters()
    func tapOnTheLocations()
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func tapOnTheCharacters() {
        router?.showCharacters()
    }
    
    func tapOnTheLocations() {
        router?.showLocations()
    }
    

}
