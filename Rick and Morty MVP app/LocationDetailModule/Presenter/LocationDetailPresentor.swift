//
//  LocationDetailPresentor.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import Foundation

protocol LocationDetailViewProtocol: AnyObject {
    func success()
    func failure(error: NetworkError)
    func setLocation(location: LocationResult?)
}

protocol LocationDetailViewPresenterProtocol: AnyObject {
    init(view: LocationDetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, location: LocationResult?)
    
    var residents: [Character?] {get set}
    var location: LocationResult? {get set}
    
    func getResidentsIdsString(location: LocationResult) -> String?
    func getCharacters(ids: String)
    func getCharacter(ids: String)
    func getCollectionOfResidents()
    func numberOfSection() -> Int
    func numberOfItemsInSection(in section: Int) -> Int
    
    func setLocation()

    func tapOnTheCharacter(character: Character?)
}

class LocationDetailPresenter: LocationDetailViewPresenterProtocol {


    
    weak var view: LocationDetailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var residents: [Character?] = []
    var location: LocationResult?
    
    required init(view: LocationDetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, location: LocationResult?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.location = location
        
        getCollectionOfResidents()
    }
    
    func getCollectionOfResidents() {
        if let location = self.location {
            guard let residentsIdsString = getResidentsIdsString(location: location) else { return }

            getCharacters(ids: residentsIdsString)

            

                
            }
        
        
    }
    
    func getResidentsIdsString(location: LocationResult) -> String? {
        var residentsIds: [String] = []
        guard let residents = location.residents else { return nil }
        for resident in residents {
            if let id = resident.components(separatedBy: "/").last {
                residentsIds.append(id)
            }
        }
        
        return residentsIds.joined(separator: ",")
    }
    
    func getCharacters(ids: String) {
        networkService.getMultipleCharacters(parameters: nil, ids: ids) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.residents = data
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error )
                }
            }
        }
    }
    
    func getCharacter(ids: String) {
        networkService.getSingleCharacter(parameters: nil, id: ids) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.residents = [data]
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error )
                }
            }
        }
    }
    
    func numberOfSection() -> Int {
        1
    }
    
    func numberOfItemsInSection(in section: Int) -> Int {
        return self.residents.count
    }
    
    func tapOnTheCharacter(character: Character?) {
        router?.showCharacterDetails(character: character)
    }
    

    func setLocation() {
        self.view?.setLocation(location: self.location)
    }
    

    
    
}
