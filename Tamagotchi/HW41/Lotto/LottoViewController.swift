//
//  LottoViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

class LottoViewController: UIViewController {
    private let rootView = LottoView()
    private let viewModel = LottoViewModel()
	private let disposeBag = DisposeBag()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    func bind() {
        let input = LottoViewModel.Input(
            searchButtonTap: rootView.fetchButton.rx.tap,
            searchText: rootView.numberTextField.rx.text.orEmpty
        )

        let output = viewModel.transform(input: input)

        output.lotto
            .subscribe(with: self) { owner, lotto in
                owner.rootView.resultLable.text = "1볼: \(lotto.drwtNo1), 2볼: \(lotto.drwtNo2), 3볼: \(lotto.drwtNo3), 4볼: \(lotto.drwtNo4), 5볼: \(lotto.drwtNo5), 6볼: \(lotto.drwtNo6), 보너스 볼: \(lotto.bnusNo)"
            } onError: { onwer, error in
                print(error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
}
