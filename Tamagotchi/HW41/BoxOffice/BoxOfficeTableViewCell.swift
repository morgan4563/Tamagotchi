//
//  BoxOfficeTableViewCell.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {
	
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)

        return label
    }()


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none

        contentView.addSubview(movieNameLabel)
        movieNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
    }
}
