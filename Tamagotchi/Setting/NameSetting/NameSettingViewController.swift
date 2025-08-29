//
//  NameSettingViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

class NameSettingViewController: UIViewController {
    private let rootView = NameSettingView()
    private let viewModel = NameSettingViewModel()
    private let disposeBag = DisposeBag()

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
        let input = NameSettingViewModel.Input(
            saveButtonTapped: navigationItem.rightBarButtonItem!.rx.tap,
            nicknameTextField: rootView.nameTextField.rx.text.orEmpty
        )
        let output = viewModel.transform(input: input)

        output.dismiss
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        output.makeToast
            .bind(with: self) { owner, toastMessage in
                owner.rootView.makeToast(toastMessage)
            }
            .disposed(by: disposeBag)
    }
}
