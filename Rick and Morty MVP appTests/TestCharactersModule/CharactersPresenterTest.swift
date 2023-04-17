//
//  CharactersPresenterTest.swift
//  Rick and Morty MVP appTests
//
//  Created by Mark Golubev on 28/03/2023.
//

import XCTest
@testable import Rick_and_Morty_MVP_app

// MARK: - MockView

class MockView: CharactersViewProtocol {
    
    func startActivity() {
        
    }
    
    func stopActivity() {
        
    }
    
    func failure(error: Rick_and_Morty_MVP_app.NetworkError) {
        
    }

    
    func success() {
        
    }
    
    

}

// MARK: - MockNetworkService

class MockNetworkService: NetworkServiceProtocol {
    var characters: [Character]!
    
    init() {}
    
    convenience init(characters: [Character]?) {
        self.init()
        self.characters = characters
    }
    
    func getCharacters(parameters: [String : Any]?, completionHandler: @escaping (Result<Rick_and_Morty_MVP_app.CharactersModel, Rick_and_Morty_MVP_app.NetworkError>) -> Void) {
        if let characters = characters {
            completionHandler(.success(CharactersModel(info: nil, results: characters)))
        } else {
            let error = NetworkError.urlError
            completionHandler(.failure(error))
        }
    }
    
    
}
// MARK: - CharactersPresenterTest

final class CharactersPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: CharactersPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var characters = [Character]()

    override func setUpWithError() throws {
        let nav = UINavigationController()
        let assembley = AssembleyModuleBuilder()
        router = Router(navigationController: nav, assembleyBuilder: assembley)

    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
        characters = []
    }

    // MARK: - testGetSuccesCharacters
    func testGetSuccesCharacters() {
        let character = Character(id: 1, name: "Foo", status: .alive, species: .alien, type: "Bar", gender: .female, origin: Location(name: "Baz", url: "Foo"), location: Location(name: "Baz", url: "Foo"), image: "https://m.media-amazon.com/images/I/61D0QLJU-hL._AC_SL1100_.jpg", episode: ["https://rickandmortyapi.com/api/episode/27"], url: "https://rickandmortyapi.com/api/character/361", created: nil)
        characters.append(character)
        
        view = MockView()
        networkService = MockNetworkService(characters: [character])
        presenter = CharactersPresenter(view: view, networkService: networkService, router: router)
        
        var catchCharacters: [Character]?
        
        networkService.getCharacters(parameters: nil) { result in
            switch result {
            case .success(let data):
                catchCharacters = data.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        XCTAssertNotEqual(catchCharacters?.count, 0)
        XCTAssertEqual(catchCharacters?.count, characters.count)
    }
    
    // MARK: - testGetFailureCharacters
    func testGetFailureCharacters() {
        let character = Character(id: 1, name: "Foo", status: .alive, species: .alien, type: "Bar", gender: .female, origin: Location(name: "Baz", url: "Foo"), location: Location(name: "Baz", url: "Foo"), image: "https://m.media-amazon.com/images/I/61D0QLJU-hL._AC_SL1100_.jpg", episode: ["https://rickandmortyapi.com/api/episode/27"], url: "https://rickandmortyapi.com/api/character/361", created: nil)
        characters.append(character)
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = CharactersPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: NetworkError?
        
        networkService.getCharacters(parameters: nil) { result in
            switch result {
            case .success( _):
                break
            case .failure(let error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError, "error no nil")
        XCTAssertEqual(catchError, .urlError)
    }
}
