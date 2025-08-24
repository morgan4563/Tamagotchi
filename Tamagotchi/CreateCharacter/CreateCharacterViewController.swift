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
    let disposeBag = DisposeBag()
    let rootView = CreateCharacterView()

    override func loadView() {
        view = rootView
    }

    let data = [
        TamagochiData(name: "따끔따끔 다마고치", iamgeName: "1-6"),
        TamagochiData(name: "방싱방실 다마고치", iamgeName: "2-6"),
        TamagochiData(name: "반짝반짝 다마고치", iamgeName: "3-6"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
        TamagochiData(name: "준비중이에요", iamgeName: "noImage"),
    ]

    lazy var items = BehaviorSubject(value: data)

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        navigationItem.title = "다마고치 선택하기"
    }

    private func bind() {
        items
            .bind(to: rootView.collectionView.rx.items(
                cellIdentifier: CharacterCollectionViewCell.identifier,
                cellType: CharacterCollectionViewCell.self)
            ) { row, model, cell in
                cell.configure(ImageName: model.iamgeName, characterName: model.name)
            }
            .disposed(by: disposeBag)
    }
}
