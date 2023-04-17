//
//  UIViewExtensions.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func round( _ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
