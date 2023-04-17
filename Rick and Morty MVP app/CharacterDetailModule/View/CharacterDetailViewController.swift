//
//  CharacterDetailViewController.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import UIKit
import SnapKit
import SDWebImage

class CharacterDetailViewController: UIViewController {
    
    var presenter: CharacterDetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setCharacter()
        setupView()
    }

    // MARK: - Private properties
    private let characterPhotoImageView: UIImageView = {
        let image = UIImageView()
        image.round()
        return image
    }()
    
    private let terminaredStampImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "terminated")
        image.isHidden = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    

}

extension CharacterDetailViewController {
    
    // MARK: - Initialize view
    func setupView() {
        view.backgroundColor = K.Design.appBackgroundColor
        
        view.addSubview(characterPhotoImageView)
        
        characterPhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        characterPhotoImageView.addSubview(terminaredStampImageView)
        terminaredStampImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(10)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(characterPhotoImageView.snp.bottom).offset(10)
        }
        
        view.addSubview(speciesLabel)
        speciesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
    }
}

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    func setCharacter(character: Character?) {
        guard let character = character else { return }
        nameLabel.text = character.name
        speciesLabel.text = character.species?.rawValue
        characterPhotoImageView.sd_setImage(with: URL(string: character.image ?? "https://m.media-amazon.com/images/I/61D0QLJU-hL._AC_SL1100_.jpg"))
//        terminaredStampImageView.isHidden = character.isAlive ? true : false
    }
    
    
}
