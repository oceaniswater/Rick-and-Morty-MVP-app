//
//  LocationsPresenter.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import Foundation

protocol LocationsViewProtocol: AnyObject {
    func success()
    func failure(error: NetworkError)
    func startActivity()
    func stopActivity()
}

protocol LocationsViewPresenterProtocol: AnyObject {
    init(view: LocationsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getLocations()
    func getFilteredLocations(name: String)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    var locations: [LocationResult]? {get set}
    func tapOnTheLocation(location: LocationResult?)
}

class LocationsPresenter: LocationsViewPresenterProtocol {
    
    weak var view: LocationsViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var locations: [LocationResult]?
    
    required init(view: LocationsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getLocations()
    }
    
    func getLocations() {
        view?.startActivity()
        networkService.getLocations(parameters: nil) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.locations = data.results
                    self.view?.success()
                    self.view?.stopActivity()
                case .failure(let error):
                    self.view?.failure(error: error )
                    self.view?.stopActivity()
                }
            }
        }
        
    }
    
    func getFilteredLocations(name: String) {
        let parametrs = ["name": name]
        view?.startActivity()
        networkService.getLocations(parameters: parametrs) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.locations = data.results
                    self.view?.success()
                    self.view?.stopActivity()
                case .failure(let error):
                    self.view?.failure(error: error )
                    self.view?.stopActivity()
                }
            }
        }
       
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.locations?.count ?? 0
    }
    

    
    func tapOnTheLocation(location: LocationResult?) {
        router?.showLocationDetail(location: location)
    }
    
    
}
