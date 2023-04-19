//
//  MainViewController.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 28/03/2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private properties
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        return image
    }()
 
}

private extension MainViewController {
    func setupView() {
        guard let navBar = navigationController?.navigationBar else { return }
    
        navBar.tintColor = K.Design.appTextColor

        navigationItem.backButtonTitle = "Back"
        
        view.backgroundColor = K.Design.appBackgroundColor

        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
    }
}

extension MainViewController: MainViewProtocol {

}
