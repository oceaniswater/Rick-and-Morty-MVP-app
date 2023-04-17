//
//  RouterTest.swift
//  Rick and Morty MVP appTests
//
//  Created by Mark Golubev on 29/03/2023.
//

import XCTest
@testable import Rick_and_Morty_MVP_app

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    var assembley = AssembleyModuleBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assembleyBuilder: assembley)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() {
        router.showCharacterDetails(character: nil)
        let detaiVC = navigationController.presentedVC
        XCTAssertTrue(detaiVC is CharacterDetailViewController)
    }
}
