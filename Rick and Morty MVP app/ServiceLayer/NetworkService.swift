//
//  NetworkService.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func getCharacters(
        parameters: [String: Any]?,
        completionHandler: @escaping (_ result: Result<CharactersModel, NetworkError>) -> Void)
    
    func getSingleCharacter(
        parameters: [String: Any]?, id: String,
        completionHandler: @escaping (_ result: Result<Character, NetworkError>) -> Void)
    
    func getMultipleCharacters(
        parameters: [String: Any]?, ids: String,
        completionHandler: @escaping (_ result: Result<[Character], NetworkError>) -> Void)
    
    func getLocations(parameters: [String: Any]?,
                      completionHandler: @escaping (_ result: Result<LocationsModel, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class NetworkService: NetworkServiceProtocol {
    
    func getLocations(parameters: [String : Any]?, completionHandler: @escaping (Result<LocationsModel, NetworkError>) -> Void) {

            let urlString = K.Network.serverAddress + "location/"
            
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.urlError))
                return
            }
            
            AF.request(url, parameters: parameters).validate().responseDecodable(of: LocationsModel.self) { response in

                switch response.result {
                case .success(let location):
                    completionHandler(.success(location))
                case .failure(_):
                    completionHandler(.failure(.canNotParseData))
                }
            }
            

    }
    
    
    func getCharacters(
        parameters: [String: Any]? = nil,
        completionHandler: @escaping (_ result: Result<CharactersModel, NetworkError>) -> Void) {
            
            let urlString = K.Network.serverAddress + "character/"
            
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.urlError))
                return
            }
            
            AF.request(url, parameters: parameters).validate().responseDecodable(of: CharactersModel.self) { response in

                switch response.result {
                case .success(let characters):
                    completionHandler(.success(characters))
                case .failure(_):
                    completionHandler(.failure(.canNotParseData))
                }
            }
            

    }
    
    func getSingleCharacter(parameters: [String : Any]?, id: String, completionHandler: @escaping (Result<Character, NetworkError>) -> Void) {
        
        let urlString = K.Network.serverAddress + "character/" + id
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: Character.self) { response in

            switch response.result {
            case .success(let character):
                completionHandler(.success(character))
            case .failure(_):
                completionHandler(.failure(.canNotParseData))
            }
        }
    }
    
    
    func getMultipleCharacters(parameters: [String : Any]?, ids: String, completionHandler: @escaping (Result<[Character], NetworkError>) -> Void) {
        
        let urlString = K.Network.serverAddress + "character/" + ids
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(url, parameters: parameters).validate().responseDecodable(of: [Character].self) { response in

            switch response.result {
            case .success(let characters):
                completionHandler(.success(characters))
            case .failure(_):
                completionHandler(.failure(.canNotParseData))
            }
        }
    }
}
