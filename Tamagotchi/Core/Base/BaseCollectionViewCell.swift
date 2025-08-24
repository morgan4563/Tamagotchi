//
//  BaseCollectionViewCell.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, ViewDesignProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureLayout()
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() {

    }

    func configureLayout() {

    }

    func configureView() {
        backgroundColor = UIColor.tamagochiBackground
    }
}
