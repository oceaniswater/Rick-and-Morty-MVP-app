//
//  ModuleBuilder.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 28/03/2023.
//

import UIKit

protocol AssembleyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createCharactersModule(router: RouterProtocol) -> UIViewController
    func createCharacterDetailModule(character: Character?, router: RouterProtocol) -> UIViewController
    
    func createLocationsModule(router: RouterProtocol) -> UIViewController
    func createLocationDetailModule(location: LocationResult?, router: RouterProtocol) -> UIViewController
}

class AssembleyModuleBuilder: AssembleyBuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCharactersModule(router: RouterProtocol) -> UIViewController {
        let view = CharactersViewController()
        let networkService = NetworkService()
        let presenter = CharactersPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCharacterDetailModule(character: Character?, router: RouterProtocol) -> UIViewController {
        let view = CharacterDetailViewController()
        let networkService = NetworkService()
        let presenter = CharacterDetailPresenter(view: view, networkService: networkService, router: router, character: character)
        view.presenter = presenter
        return view
    }
    
    func createLocationsModule(router: RouterProtocol) -> UIViewController {
        let view = LocationsViewController()
        let networkService = NetworkService()
        let presenter = LocationsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createLocationDetailModule(location: LocationResult?, router: RouterProtocol) -> UIViewController {
        let view = LocationDetailViewController()
        let networkService = NetworkService()
        let presenter = LocationDetailPresenter(view: view, networkService: networkService, router: router, location: location)
        view.presenter = presenter
        return view
    }
    
    
}
