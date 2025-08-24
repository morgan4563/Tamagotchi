//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let rootView = MainView()
    let viewModel = MainViewModel()
    var currentData: TamagochiData?
    let disposeBag = DisposeBag()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        bind()
    }

    func configure(data: TamagochiData) {
        currentData = data
        rootView.bubbleMessage.text = "안녕하세요" // 추후 변경필요
        rootView.nameLabel.text = data.name
        rootView.characterImage.image = UIImage(named: data.iamgeName)

        updateLv()
        updateImage()
        updateStatusLabel()
    }

    private func bind() {
        rootView.riceButton.rx.tap
            .withLatestFrom(rootView.riceTextField.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                guard var data = owner.currentData else { return }
                let count: Int
                if text.isEmpty {
                    count = 1
                } else if let num = Int(text), num > 0, num <= 99 {
					count = num
                } else {
                    owner.rootView.bubbleMessage.text = "정확한 값을 입력해주세요!"
                    return
                }
                data.rice += count
                owner.currentData = data
                owner.rootView.bubbleMessage.text = "밥 맛있어요!"

                owner.updateLv()
                owner.updateImage()
                owner.updateStatusLabel()
            }
            .disposed(by: disposeBag)

        rootView.waterButton.rx.tap
            .withLatestFrom(rootView.waterTextField.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                guard var data = owner.currentData else { return }
                let count: Int
                if text.isEmpty {
                    count = 1
                } else if let num = Int(text), num > 0, num <= 49 {
                    count = num
                } else {
                    owner.rootView.bubbleMessage.text = "정확한 값을 입력해주세요!"
                    return
                }
                data.water += count
                owner.currentData = data
                owner.rootView.bubbleMessage.text = "물 맛있어요!"

                owner.updateLv()
                owner.updateImage()
                owner.updateStatusLabel()
            }
            .disposed(by: disposeBag)
    }

    private func updateStatusLabel() {
        guard let data = currentData else { return }
        rootView.statusLabel.text = "LV\(data.lv) • 밥알 \(data.rice) • 물방울 \(data.water)"
    }

    private func updateLv() {
        guard var data = currentData else { return }
        let lv = min(10, max(1,(Int((Double(data.rice) / 5.0) + (Double(data.water) / 2.0)) / 10)))
        data.lv = lv
        currentData = data
    }

    private func updateImage() {
        guard let data = currentData, data.lv < 10 else { return }
        let newImageString = "\(data.id)-\(data.lv)"
        currentData?.iamgeName = newImageString
        rootView.characterImage.image = UIImage(named: newImageString)
    }

    func configureNavigation() {
        navigationItem.title = "\(currentData?.owner ?? "")님의 다마고치"
    }
}
