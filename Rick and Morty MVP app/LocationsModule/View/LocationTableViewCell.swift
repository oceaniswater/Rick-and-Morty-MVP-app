//
//  LocationTableViewCell.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    public static var identifier: String {
        get {
            return "LocationTableCell"
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = K.Design.appTextColor
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
    }
    
    // MARK: - Public methods
    func configure(with location: LocationResult) {
        nameLabel.text = location.name

    }
}

extension LocationTableViewCell {
    func setupCell() {
        backgroundColor = K.Design.appBackgroundColor
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        

    }
}


