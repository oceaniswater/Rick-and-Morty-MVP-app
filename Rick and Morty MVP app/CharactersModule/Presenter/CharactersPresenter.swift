//
//  CharactersPresenter.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import Foundation

protocol CharactersViewProtocol: AnyObject {
    func success()
    func failure(error: NetworkError)
    func startActivity()
    func stopActivity()
}

protocol CharactersViewPresenterProtocol: AnyObject {
    init(view: CharactersViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getCharacters()
    func getFilteredCharacters(name: String)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    var characters: [Character]? {get set}
    func tapOnTheCharacter(character: Character?)
}

class CharactersPresenter: CharactersViewPresenterProtocol {

    weak var view: CharactersViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var characters: [Character]?
    
    required init(view: CharactersViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getCharacters()
    }
    
    func tapOnTheCharacter(character: Character?) {
        router?.showCharacterDetails(character: character)
    }
    
    func getCharacters() {
        view?.startActivity()
        networkService.getCharacters(parameters: nil) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.characters = data.results
                    self.view?.success()
                    self.view?.stopActivity()
                case .failure(let error):
                    self.view?.failure(error: error )
                    self.view?.stopActivity()
                }
            }
        }
    }
    
    func getFilteredCharacters(name: String) {
        let parameters = ["name": name]
        
        view?.startActivity()
        networkService.getCharacters(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.characters = data.results
                    self.view?.success()
                    self.view?.stopActivity()
                case .failure(let error):
                    self.view?.failure(error: error )
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.characters?.count ?? 0
    }
}
