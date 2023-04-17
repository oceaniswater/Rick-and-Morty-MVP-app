//
//  AppConstants.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 31/03/2023.
//

import Foundation
import UIKit

struct K {
    struct Design {
        static let appBackgroundColor = UIColor(named: "appBackgroundColor")
        static let appTextColor = UIColor(named: "appTextColor")
        
        static let buttonSelectedBackgroundColor = UIColor(named: "buttonSelectedBackgroundColor")
        
        static let cellBackgroundColor = UIColor(named: "cellBackgroundColor")
        static let cellBoundColor = UIColor(named: "cellBoundColor")
    }
    
    struct Network {
        static let serverAddress = "https://rickandmortyapi.com/api/"
    }
}
