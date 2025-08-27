//
//  CreateCharacterPopUpViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateCharacterPopUpViewController: UIViewController {
    private let rootView = CreateCharacterPopUpView()
    private let disposeBag = DisposeBag()
    let startButtonTapped = PublishRelay<TamagochiData>()
    private var currentData: TamagochiData

    init(currentData: TamagochiData) {
        self.currentData = currentData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CreateCharacterPopUpViewController deinit")
    }

    override func loadView() {
		view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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
                owner.startButtonTapped.accept(owner.currentData)
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }

    func configureView() {
        rootView.imageView.image = UIImage(named: currentData.imageName)
        rootView.nameLabel.text = currentData.name
        rootView.descriptionLabel.text = currentData.description
    }
}
