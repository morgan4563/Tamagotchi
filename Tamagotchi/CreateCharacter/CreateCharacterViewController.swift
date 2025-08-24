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
    let viewModel = CreateCharacterViewModel()

    override func loadView() {
        view = rootView
    }

    let data = [
        TamagochiData(name: "따끔따끔 다마고치", iamgeName: "1-6", description: "저는 따끔따끔 다마고치치"),
        TamagochiData(name: "방싱방실 다마고치", iamgeName: "2-6", description: "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니다 방실방실!"),
        TamagochiData(name: "반짝반짝 다마고치", iamgeName: "3-6", description: "저는 따끔따끔 다마고치치"),
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
        let input = CreateCharacterViewModel.Input(itemSelected: rootView.collectionView.rx.modelSelected(TamagochiData.self))

        let output = viewModel.transform(input: input)

        items
            .bind(to: rootView.collectionView.rx.items(
                cellIdentifier: CharacterCollectionViewCell.identifier,
                cellType: CharacterCollectionViewCell.self)
            ) { row, model, cell in
                cell.configure(ImageName: model.iamgeName, characterName: model.name)
            }
            .disposed(by: disposeBag)


        output.presentPopUp
            .bind(with: self) { owner, nextVC in
                owner.present(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
