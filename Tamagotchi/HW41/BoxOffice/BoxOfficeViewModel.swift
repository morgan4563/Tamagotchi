//
//  BoxOfficeViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel {
	private let disposeBag = DisposeBag()

    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }

    struct Output {
        let list: BehaviorRelay<[Movie]>
    }

    func transform(input: Input) -> Output {
        let list: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])

        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovie(query: text)
            }
            .debug("서치바")
            .subscribe(with: self) { owner, movie in
                let movieArray = movie.boxOfficeResult.dailyBoxOfficeList
                list.accept(movieArray)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)


        return Output(list: list)
    }
}
