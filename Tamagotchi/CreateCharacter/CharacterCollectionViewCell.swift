//
//  CharacterCollectionViewCell.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import SnapKit

final class CharacterCollectionViewCell: BaseCollectionViewCell {

    let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let nameLabel: UILabel = {
		let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .tamagochiLine

        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.tamagochiLine.cgColor
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    override func configureHierarchy() {
        contentView.addSubview(characterImage)
        contentView.addSubview(nameLabel)
    }

    override func configureLayout() {
        characterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(characterImage.snp.width)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
        nameLabel.text = nil
    }

    func configure(ImageName: String, characterName: String) {
        characterImage.image = UIImage(named: ImageName)
        nameLabel.text = characterName
    }
}
