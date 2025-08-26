//
//  LottoViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel {
	let disposeBag = DisposeBag()

    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }

    struct Output {
        let lotto: PublishSubject<Lotto>
    }

    func transform(input: Input) -> Output {
        let lotto = PublishSubject<Lotto>()

        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .flatMap { text in
                CustomObservable.getLotto(query: text)
                    .catch { _ in
                        Observable.never()
                    }
            }
            .bind(to: lotto)
            .disposed(by: disposeBag)

        return Output(lotto: lotto)
    }
}
