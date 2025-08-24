//
//  CreateCharacterViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class CreateCharacterViewModel {
    let disposeBag = DisposeBag()

    struct Input {
        let itemSelected: ControlEvent<TamagochiData>
    }

    struct Output {
        let presentPopUp: PublishRelay<UIViewController>
    }

    init() {
        
    }

    func transform(input: Input) -> Output {
		let vc = PublishRelay<UIViewController>()

        input.itemSelected
            .bind(with: self) { owner, value in
                let nextVC = CreateCharacterPopUpViewController()
                nextVC.configure(data: value)
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.modalTransitionStyle = .crossDissolve

                vc.accept(nextVC)
            }
            .disposed(by: disposeBag)
		return Output(presentPopUp: vc)
    }
}
