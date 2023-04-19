//
//  MainTabBarController.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 18/04/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var presenter: TabBarPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarApperance()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewControllers = presenter?.generateTabBarItems()
        selectedIndex = 1
        
    }
    
    // for adopt tab bar color scheme for dark/light mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                let color = K.Design.cellBackgroundColor ?? .white
                let roundLayer = self.tabBar.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer
                roundLayer?.fillColor = color.cgColor
                
                roundLayer?.strokeColor = K.Design.cellBoundColor?.cgColor
                roundLayer?.lineWidth = 2
                
            }
        }
    }
    
    private func setTabBarApperance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = K.Design.cellBackgroundColor?.cgColor // Set background of custom tabbar
        roundLayer.strokeColor = K.Design.cellBoundColor?.cgColor // Set border color here
        roundLayer.lineWidth = 2 // Set  border width here

        tabBar.backgroundColor = nil
        tabBar.tintColor = K.Design.appTextColor // Set color of selected elements
        tabBar.unselectedItemTintColor = K.Design.appUnselectedTextColor // Set color of unselected elements
        
    }
    
}

extension MainTabBarController: TabBarProtocol {
    
}
