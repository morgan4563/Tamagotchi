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
	private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()

        bind()
    }

    let numberTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 15, weight: .semibold)
        tf.borderStyle = .roundedRect
        tf.placeholder = "회차를 입력해주세요."

        return tf
    }()

    let fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .red

        return button
    }()

    let resultLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "여기에 로또 결과가 표시됩니다."
        label.numberOfLines = 2

        return label
    }()

    func configureHierarchy() {
        view.addSubview(numberTextField)
        view.addSubview(fetchButton)
        view.addSubview(resultLable)
    }

    func configureLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
        }

        fetchButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(32)
            make.centerX.equalTo(numberTextField)
        }

        resultLable.snp.makeConstraints { make in
            make.top.equalTo(fetchButton.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
    }

    func bind() {
        fetchButton.rx.tap
            .withLatestFrom(numberTextField.rx.text.orEmpty)
            .flatMap { text in
                CustomObservable.getLotto(query: text)
            }
            .subscribe(with: self) { owner, lotto in
                owner.resultLable.text = "1볼: \(lotto.drwtNo1), 2볼: \(lotto.drwtNo2), 3볼: \(lotto.drwtNo3), 4볼: \(lotto.drwtNo4), 5볼: \(lotto.drwtNo5), 6볼: \(lotto.drwtNo6), 보너스 볼: \(lotto.bnusNo)"
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
