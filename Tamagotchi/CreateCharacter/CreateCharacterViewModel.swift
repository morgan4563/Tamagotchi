//
//  CreateCharacterViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class CreateCharacterViewModel {
    private let disposeBag = DisposeBag()
    private let data = [
        TamagochiData(id: 1, name: "따끔따끔 다마고치", iamgeName: "1-6", description: "저는 따끔따끔 다마고치치"),
        TamagochiData(id: 2, name: "방싱방실 다마고치", iamgeName: "2-6", description: "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니다 방실방실!"),
        TamagochiData(id: 3, name: "반짝반짝 다마고치", iamgeName: "3-6", description: "저는 반짝반짝 다마고치치입니다."),
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

    struct Input {
        let viewDidLoad: Observable<Void>
        let itemSelected: ControlEvent<TamagochiData>
    }

    struct Output {
        let selectedTamaData: PublishRelay<TamagochiData>
        let item: BehaviorRelay<[TamagochiData]>
    }

    init() {

    }

    func transform(input: Input) -> Output {
		let selectedTamaData = PublishRelay<TamagochiData>()
        let item = BehaviorRelay<[TamagochiData]>(value: data)

        input.itemSelected
            .filter{ $0.id != 0 }
            .bind(with: self) { owner, value in
                var tama = UserDefaults.standard.loadTamagochi() ?? TamagochiData(id: value.id, name: value.name, iamgeName: value.imageName, description: value.description, owner: "대장", lv: value.lvDescription, rice: 0, water: 0)

                tama.id = value.id
                tama.imageName = value.imageName
                tama.name = value.name

                selectedTamaData.accept(tama)
            }
            .disposed(by: disposeBag)

        return Output(
            selectedTamaData: selectedTamaData,
            item: item
        )
    }
}
