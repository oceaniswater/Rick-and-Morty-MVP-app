//
//  ResidentCollectionViewCell.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 05/04/2023.
//

import UIKit
import SDWebImage

class ResidentCollectionViewCell: UICollectionViewCell {
    
    public static var identifier: String {
        get {
            return "ResidentCollectionCell"
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private let residentImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        residentImage.image = nil
    }
    
    // MARK: - Public methods
    func configure(with character: Character) {
        residentImage.sd_setImage(with: URL(string: character.image ?? "https://m.media-amazon.com/images/I/61D0QLJU-hL._AC_SL1100_.jpg"))
    }
}

// MARK: - Private methods
private extension ResidentCollectionViewCell {
    func setupCell() {
        contentView.addSubview(residentImage)
        residentImage.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        contentView.backgroundColor = .clear
    }
}
