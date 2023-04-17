//
//  Router.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var assembleyBuilder: AssembleyBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showCharacters()
    func showCharacterDetails(character: Character?)
    
    func popToCharactersVC()
    func popToRootVC()
    
    func showLocations()
    func showLocationDetail(location: LocationResult?)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assembleyBuilder: AssembleyBuilderProtocol?
    
    init(navigationController: UINavigationController, assembleyBuilder: AssembleyBuilderProtocol) {
        self.navigationController = navigationController
        self.assembleyBuilder = assembleyBuilder
    }
    
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = self.assembleyBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    // MARK: - Characters - Character Detail
    func showCharacters() {
        if let navigationController = navigationController {
            guard let charactersViewController = self.assembleyBuilder?.createCharactersModule(router: self) else {return}
            DispatchQueue.main.async {
                navigationController.pushViewController(charactersViewController, animated: true)
            }
            
        }
    }
    
    func showCharacterDetails(character: Character?) {
        if let navigationController = navigationController {
            guard let detailViewController = self.assembleyBuilder?.createCharacterDetailModule(character: character, router: self) else {return}
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToCharactersVC() {
        if let navigationController = navigationController {
            guard let charactersViewController = self.assembleyBuilder?.createCharactersModule(router: self) else {return}
            navigationController.popToViewController(charactersViewController, animated: true)
        }
    }
    
    func popToRootVC() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Locations - Location Detail
    func showLocations() {
        if let navigationController = navigationController {
            guard let locationsViewController = self.assembleyBuilder?.createLocationsModule(router: self) else {return}
            DispatchQueue.main.async {
                navigationController.pushViewController(locationsViewController, animated: true)
            }
            
        }
    }
    
    func showLocationDetail(location: LocationResult?) {
        if let navigationController = navigationController {
            guard let detailViewController = self.assembleyBuilder?.createLocationDetailModule(location: location, router: self) else {return}
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    

    
    
}
