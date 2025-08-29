//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let rootView = MainView()
    let viewModel = MainViewModel()
    var currentData: TamagochiData?
    let disposeBag = DisposeBag()
    let viewWillAppearRelay = PublishRelay<Void>()

    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())

    }

    func configure(data: TamagochiData) {
    	currentData = data
        rootView.nameLabel.text = data.name
        rootView.characterImage.image = UIImage(named: data.imageName)
    }

    private func bind() {
        let input = MainViewModel.Input(
            riceButtonTap: rootView.riceButton.rx.tap,
            riceTextField: rootView.riceTextField.rx.text.orEmpty,
            waterButtonTap: rootView.waterButton.rx.tap,
            waterTextField: rootView.waterTextField.rx.text.orEmpty,
            viewWillAppearObservable: viewWillAppearRelay
        )

        let output = viewModel.transform(input: input)

        output.bubbleMessage
            .drive(rootView.bubbleMessage.rx.text)
            .disposed(by: disposeBag)

        output.currentData
            .compactMap { $0 }
            .drive(with: self) { owner, data in
                owner.configure(data: data)
                owner.navigationItem.title = "\(data.owner)님의 다마고치"
            }
            .disposed(by: disposeBag)

        output.statusText
            .drive(rootView.statusLabel.rx.text)
            .disposed(by: disposeBag)

        output.imageName
            .drive(with: self) { owner, name in
                owner.rootView.characterImage.image = UIImage(named: name)
            }
            .disposed(by: disposeBag)

        output.titleText
            .drive(with: self) { owner, title in
                owner.navigationItem.title = title
            }
            .disposed(by: disposeBag)

        output.nameText
            .drive(with: self) { owner, name in
                owner.rootView.nameLabel.text = name
            }
            .disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx.tap
            .bind(with: self) { owner, _ in
                let settingVC = SettingViewController()
                owner.navigationController?.pushViewController(settingVC, animated: true)
            }
            .disposed(by: disposeBag)
    }

    private func configureNavigation() {
        navigationItem.title = "\(currentData?.owner ?? "")님의 다마고치"
        navigationItem.hidesBackButton = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .tamagochiLine
        navigationItem.backButtonDisplayMode = .minimal
    }
}
