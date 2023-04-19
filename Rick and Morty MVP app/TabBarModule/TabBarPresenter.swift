//
//  TabBarPresenter.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 18/04/2023.
//

import Foundation
import UIKit

protocol TabBarProtocol: AnyObject {
}

protocol TabBarPresenterProtocol: AnyObject {
    init(tabBar: TabBarProtocol, router: RouterProtocol, viewControllers: [UIViewController])
    func generateTabBarItems() -> [UIViewController]?
    func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController
}

class TabBarPresenter: TabBarPresenterProtocol {

    weak var tabBar: TabBarProtocol?
    var router: RouterProtocol?
    var vc: [UIViewController]?
    let titles = ["Characters","Home", "Locations"]
    let images = ["person.fill","house.fill", "mappin.and.ellipse"]
    
    required init(tabBar: TabBarProtocol, router: RouterProtocol, viewControllers: [UIViewController]) {
        self.tabBar = tabBar
        self.router = router
        self.vc = viewControllers
    }
    
    
    func generateTabBarItems() -> [UIViewController]? {
        guard let vc = vc else {return nil}
        var viewControllers: [UIViewController] = []
        for i in 0..<vc.count {
            viewControllers.append(generateVC(viewController: vc[i], title: titles[i], image: UIImage(systemName: images[i])))
        }
        return viewControllers
    }
    
    func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
            viewController.tabBarItem.title = title
            viewController.tabBarItem.image = image
            return viewController
    }
    
}
