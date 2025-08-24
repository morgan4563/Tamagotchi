//
//  NameSettingViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

class NameSettingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let rootView = NameSettingView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
        bind()
    }

    private func bind() {
        navigationItem.rightBarButtonItem?.rx.tap
            .withLatestFrom(rootView.nameTextField.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                guard var savedData = UserDefaults.standard.loadTamagochi() else { return }
                savedData.owner = text
                UserDefaults.standard.saveTamagochi(savedData)
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
