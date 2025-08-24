//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit

class MainViewController: UIViewController {
    let rootView = MainView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func configure(data: TamagochiData) {
        rootView.bubbleMessage.text = "안녕하세요" // 추후 변경필요
        rootView.nameLabel.text = data.name
        rootView.characterImage.image = UIImage(named: data.iamgeName)
    }
}
