//
//  CreateCharacterViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateCharacterViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let rootView = CreateCharacterView()
    private let viewModel = CreateCharacterViewModel()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        navigationItem.title = "다마고치 선택하기"
    }

    private func bind() {
        let input = CreateCharacterViewModel.Input(
            viewDidLoad: Observable<Void>.just(()),
            itemSelected: rootView.collectionView.rx.modelSelected(TamagochiData.self)
        )

        let output = viewModel.transform(input: input)

        output.item
            .bind(to: rootView.collectionView.rx.items(
                cellIdentifier: CharacterCollectionViewCell.identifier,
                cellType: CharacterCollectionViewCell.self)
            ) { row, model, cell in
                cell.configure(ImageName: model.imageName, characterName: model.name)
            }
            .disposed(by: disposeBag)

        output.selectedTamaData
            .bind(with: self) { owner, tamaData in
                let nextVC = CreateCharacterPopUpViewController(currentData: tamaData)
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.modalTransitionStyle = .crossDissolve

                nextVC.startButtonTapped
                    .bind(with: self) { owner, data in
                        let mainVC = MainViewController()
                        if var savedData = UserDefaults.standard.loadTamagochi() {
                            savedData.id = data.id
                            savedData.name = data.name
                            UserDefaults.standard.saveTamagochi(savedData)
							#warning("외부에서 컨피규어 ㄴㄴ, 들어가서 유저디폴트로 변경하지")
                            mainVC.configure(data: savedData)
                        } else {
                            UserDefaults.standard.saveTamagochi(data)
                            mainVC.configure(data: data)
                        }

                        owner.navigationController?.pushViewController(mainVC, animated: true)
                    }
                    .disposed(by: owner.disposeBag)
                owner.present(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
