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
    
    
    private lazy var charactersButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Characters", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setTitleColor(K.Design.appTextColor, for: .normal)
        
        button.addTarget(self, action: #selector(charactersButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var locationsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Locations", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setTitleColor(K.Design.appTextColor, for: .normal)
        button.addTarget(self, action: #selector(locationsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var episodesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Episodes", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setTitleColor(K.Design.appTextColor, for: .normal)
        button.addTarget(self, action: #selector(episodesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private func
    
    @objc private func charactersButtonPressed() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.charactersButton.backgroundColor = K.Design.buttonSelectedBackgroundColor
        })
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.charactersButton.backgroundColor = .clear
        })
        presenter.tapOnTheCharacters()

    }
    
    @objc private func locationsButtonPressed() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.locationsButton.backgroundColor = K.Design.buttonSelectedBackgroundColor
        })
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.locationsButton.backgroundColor = .clear
        })
        presenter.tapOnTheLocations()

    }
    
    @objc private func episodesButtonPressed() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.episodesButton.backgroundColor = K.Design.buttonSelectedBackgroundColor
        })
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.episodesButton.backgroundColor = .clear
        })

    }
 
}

private extension MainViewController {
    func setupView() {
        guard let navBar = navigationController?.navigationBar else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = K.Design.appBackgroundColor

        let attributes = [NSAttributedString.Key.foregroundColor: K.Design.appTextColor,
                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
        appearance.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: K.Design.appTextColor!] as [NSAttributedString.Key : Any]
        
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        
        navBar.prefersLargeTitles = true

        navBar.tintColor = K.Design.appTextColor

        navigationItem.backButtonTitle = "Back"
        

        title = "The Rick and Morty"
        
        view.backgroundColor = K.Design.appBackgroundColor

        episodesButton.snp.makeConstraints { make in

            make.height.equalTo(50)

        }
        
        locationsButton.snp.makeConstraints { make in
            make.height.equalTo(50)

        }
        
        charactersButton.snp.makeConstraints { make in
            make.height.equalTo(50)

        }
        
        let vStack = UIStackView(arrangedSubviews: [charactersButton, locationsButton, episodesButton])
        vStack.axis = .vertical
        vStack.spacing = 10
        
        view.addSubview(vStack)
        
        vStack.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
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
