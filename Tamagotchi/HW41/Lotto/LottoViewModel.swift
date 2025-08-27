//
//  LottoViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa
import Network

final class LottoViewModel {
	let disposeBag = DisposeBag()

    let monitor = NWPathMonitor()
    let monitorQueue = DispatchQueue(label: "NetworkMonitor")

    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }

    struct Output {
        let lotto: PublishSubject<Lotto>
        let showAlert: PublishRelay<Void>
        let networkDisconnected: Driver<Void>
    }

    func transform(input: Input) -> Output {
        let lotto = PublishSubject<Lotto>()
        let showAlert = PublishRelay<Void>()
        let networkDisconnected = PublishRelay<Void>()
        
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                networkDisconnected.accept(())
            }
        }

        monitor.start(queue: monitorQueue)

        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getLotto(query: text)
                //TODO: 0828 질문 1-2. 내부에서는 success만 나올건데 catch 왜 쓰는지.
                    .catch { _ in
                        return Observable.never()
                    }
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let value):
                    lotto.onNext(value)
                case .failure(_):
                    showAlert.accept(())
                }
            }
            .disposed(by: disposeBag)

        return Output(
            lotto: lotto,
            showAlert: showAlert,
            networkDisconnected: networkDisconnected.asDriver(onErrorDriveWith: .empty())
        )
    }

    deinit { monitor.cancel() }
}
