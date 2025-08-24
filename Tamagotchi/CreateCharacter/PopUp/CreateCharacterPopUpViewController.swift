//
//  CreateCharacterPopUpViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit

class CreateCharacterPopUpViewController: UIViewController {

    let rootView = CreateCharacterPopUpView()

    override func loadView() {
		view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func configure(data: TamagochiData) {
        rootView.imageView.image = UIImage(named: data.iamgeName)
        rootView.nameLabel.text = data.name
        rootView.descriptionLabel.text = data.description
    }
}
