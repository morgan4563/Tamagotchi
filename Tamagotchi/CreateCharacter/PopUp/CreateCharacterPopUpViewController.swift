//
//  CreateCharacterPopUpViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

class CreateCharacterPopUpViewController: UIViewController {
    let rootView = CreateCharacterPopUpView()
    let disposeBag = DisposeBag()
    let startButtonTapped = PublishRelay<TamagochiData>()
    var currentData: TamagochiData?

    deinit {
        print("CreateCharacterPopUpViewController deinit")
    }

    override func loadView() {
		view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		bind()
    }

    func bind() {
        rootView.cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)

        rootView.startButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.startButtonTapped.accept(owner.currentData ?? TamagochiData(name: "", iamgeName: ""))
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }

    func configure(data: TamagochiData) {
        rootView.imageView.image = UIImage(named: data.iamgeName)
        rootView.nameLabel.text = data.name
        rootView.descriptionLabel.text = data.description
        self.currentData = data
    }
}
