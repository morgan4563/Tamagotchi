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
        let showAlert: PublishRelay<Void>
    }

    func transform(input: Input) -> Output {
        let list: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
        let showAlert = PublishRelay<Void>()

        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovieWithSingle(query: text)
                //TODO: 0828 질문 1. catch 왜 쓰는지.
                    .catch { _ in
                        return Single<Result<MovieRequest,SampleError>>.never()
                    }
            }
            .debug("서치바")
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let value):
                    print("여기실행됨")
                    let movieArray = value.boxOfficeResult.dailyBoxOfficeList
                    list.accept(movieArray)
                case .failure(_):
                    showAlert.accept(())
                }
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)


        return Output(list: list, showAlert: showAlert)
    }
}
