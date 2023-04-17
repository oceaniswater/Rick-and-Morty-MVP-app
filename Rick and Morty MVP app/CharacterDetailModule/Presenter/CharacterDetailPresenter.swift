//
//  CharacterDetailPresenter.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import Foundation

protocol CharacterDetailViewProtocol: AnyObject {
    func setCharacter(character: Character?)
}

protocol CharacterDetailViewPresenterProtocol: AnyObject {
    init(view: CharacterDetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, character: Character?)
    func setCharacter()
    func tapButtonToRoot()
}

class CharacterDetailPresenter: CharacterDetailViewPresenterProtocol {
    
    weak var view: CharacterDetailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var character: Character?
    
    required init(view: CharacterDetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, character: Character?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.character = character
    }
    
    func tapButtonToRoot() {
        router?.popToRootVC()
    }
    
    public func setCharacter() {
        self.view?.setCharacter(character: character)
    }
    
    
}
