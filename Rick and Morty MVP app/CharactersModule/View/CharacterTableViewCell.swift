//
//  CharacterTableViewCell.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import UIKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {
    
    public static var identifier: String {
        get {
            return "CharacterTableCell"
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    // overide func to suport changes border color depends on dark/light mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               view.layer.borderColor = K.Design.cellBoundColor?.cgColor
               characterImage.layer.borderColor = K.Design.cellBoundColor?.cgColor
           }
       }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = K.Design.cellBackgroundColor
        view.round(20)
        view.addBorder(color: K.Design.cellBoundColor!, width: 1)
        return view
    }()
    
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.round()
        image.addBorder(color: K.Design.cellBoundColor!, width: 1)
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "gender:"
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "species:"
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "location:"
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    private lazy var genderValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    private lazy var speciesValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    private lazy var locationValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = K.Design.appTextColor
        label.numberOfLines = 0
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImage.image = nil
        nameLabel.text = nil
        genderValueLabel.text = nil
        speciesValueLabel.text = nil
        locationValueLabel.text = nil
    }
    
    // MARK: - Public methods
    func configure(with character: Character) {
        characterImage.sd_setImage(with: URL(string: character.image ?? "https://m.media-amazon.com/images/I/61D0QLJU-hL._AC_SL1100_.jpg"))
        nameLabel.text = character.name
        genderValueLabel.text = character.gender?.rawValue
        speciesValueLabel.text = character.species?.rawValue
        locationValueLabel.text = character.location?.name
    }
}

extension CharacterTableViewCell {
    func setupCell() {
        backgroundColor = K.Design.appBackgroundColor
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(8)
        }
        
        
        view.addSubview(characterImage)
        characterImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.leading.equalToSuperview().inset(30)
        }
        
        let vLabelsStack = UIStackView(arrangedSubviews: [genderLabel, speciesLabel, locationLabel])
        vLabelsStack.axis = .vertical
        vLabelsStack.spacing = 5
        vLabelsStack.alignment = .leading
        
        let vLabelsValueStack = UIStackView(arrangedSubviews: [genderValueLabel, speciesValueLabel, locationValueLabel])
        vLabelsValueStack.axis = .vertical
        vLabelsValueStack.spacing = 5
        vLabelsValueStack.alignment = .leading
        
        let hInfoStack = UIStackView(arrangedSubviews: [vLabelsStack, vLabelsValueStack])
        hInfoStack.axis = .horizontal
        hInfoStack.spacing = 5
        hInfoStack.alignment = .leading
        
        let vFinalLabelsStack = UIStackView(arrangedSubviews: [nameLabel, hInfoStack])
        vFinalLabelsStack.axis = .vertical
        vFinalLabelsStack.spacing = 10
        
        
        view.addSubview(vFinalLabelsStack)
        vFinalLabelsStack.snp.makeConstraints { make in
            make.leading.equalTo(characterImage.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(30)
        }
    }
}
