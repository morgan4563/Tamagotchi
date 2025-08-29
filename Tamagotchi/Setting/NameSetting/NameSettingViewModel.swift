//
//  NameSettingViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/29/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NameSettingViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        let saveButtonTapped: ControlEvent<Void>
        let nicknameTextField: ControlProperty<String>
    }

    struct Output {
        let dismiss: PublishRelay<Void>
        let makeToast: PublishRelay<String>
    }

    func transform(input: Input) -> Output {
        let dismiss = PublishRelay<Void>()
        let makeToast = PublishRelay<String>()

        input.saveButtonTapped
            .withLatestFrom(input.nicknameTextField)
            .bind { text in
                guard text.count >= 2 && text.count <= 6 else {
                    makeToast.accept("닉네임은 2글자 이상 6글자 이하로 설정해주세요")
                    return
                }
                guard var currentData = UserDefaults.standard.loadTamagochi() else { return }
                currentData.owner = text
                UserDefaults.standard.saveTamagochi(currentData)
                dismiss.accept(())
            }
            .disposed(by: disposeBag)

        return Output(
            dismiss: dismiss,
            makeToast: makeToast
        )
    }
}
