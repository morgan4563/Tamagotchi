//
//  MainViewModel.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        let riceButtonTap: ControlEvent<Void>
        let riceTextField: ControlProperty<String>
        let waterButtonTap: ControlEvent<Void>
        let waterTextField: ControlProperty<String>
    }

    struct Output {
        let bubbleMessage: BehaviorRelay<String>
        let currentData: BehaviorSubject<TamagochiData?>
        let statusText: BehaviorRelay<String>
        let imageName: BehaviorRelay<String>
        let titleText: BehaviorRelay<String>
        let nameText: BehaviorRelay<String>
    }

    init() {}

    func transform(input: Input) -> Output {
        let bubbleMessage = BehaviorRelay<String>(value: "반갑습니다")
        let currentData = BehaviorSubject<TamagochiData?>(value: UserDefaults.standard.loadTamagochi())
        let statusText = BehaviorRelay<String>(value: "LV • 밥알 • 물방울 (정보 없음)")
        let imageName = BehaviorRelay<String>(value: "noImage")
        let titleText = BehaviorRelay<String>(value: "다마고치")
        let nameText = BehaviorRelay<String>(value: "다마고치")

        //MARK: 초기값 있으면 주기
        if let data = try? currentData.value() {
            statusText.accept("LV\(data.lv) • 밥알 \(data.rice) • 물방울 \(data.water)")
            imageName.accept(data.iamgeName)
            titleText.accept("\(data.owner)님의 다마고치")
            nameText.accept(data.name)
            bubbleMessage.accept("좋은 하루에요, \(data.owner)님")
        }

        input.riceButtonTap
            .withLatestFrom(input.riceTextField)
            .bind { text in
                guard var data = try? currentData.value() else {
                    bubbleMessage.accept("다마고치를 불러오지 못했습니다.")
                    return
                }

                let count: Int
                if text.isEmpty {
                    count = 1
                } else if let num = Int(text), num > 0, num <= 99 {
                    count = num
                } else {
                    bubbleMessage.accept("정확한 값을 입력해주세요!")
                    return
                }
                data.rice += count

                let score = (Double(data.rice) / 5.0) + (Double(data.water) / 2.0)
                let rawLv = Int(score / 10.0)
                let checkingLv = max(1, min(10, rawLv))
                if data.lv != checkingLv {
                    let message = "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 \(data.owner)님"
                    bubbleMessage.accept(message)
                } else {
                    let messages = ["*#님, 좋은 하루에요", "*#님 밥 주세요", "좋은 하루에요 *#님"]
                    var randomMessage = messages.randomElement()
                    randomMessage?.replace("*#", with: data.owner)
                    bubbleMessage.accept(randomMessage ?? "기분이 좋아요")
                }
                data.lv = checkingLv

                currentData.onNext(data)
                UserDefaults.standard.saveTamagochi(data)

                statusText.accept("LV\(data.lv) • 밥알 \(data.rice) • 물방울 \(data.water)")
                let lv = min(9,data.lv)
                let newImageString = "\(data.id)-\(lv)"
                imageName.accept(newImageString)
                titleText.accept("\(data.owner)님의 다마고치")
                nameText.accept(data.name)
            }
            .disposed(by: disposeBag)

        input.waterButtonTap
            .withLatestFrom(input.waterTextField)
            .bind { text in
                guard var data = try? currentData.value() else {
                    bubbleMessage.accept("다마고치를 불러오지 못했습니다.")
                    return
                }
                let count: Int
                if text.isEmpty {
                    count = 1
                } else if let num = Int(text), num > 0, num <= 49 {
                    count = num
                } else {
                    bubbleMessage.accept("정확한 값을 입력해주세요!")
                    return
                }
                data.water += count

                let score = (Double(data.rice) / 5.0) + (Double(data.water) / 2.0)
                let rawLv = Int(score / 10.0)
                let checkingLv = max(1, min(10, rawLv))
                if data.lv != checkingLv {
                    let message = "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 \(data.owner)님"
                    bubbleMessage.accept(message)
                } else {
                    let messages = ["*#님, 좋은 하루에요", "*#님 밥 주세요", "좋은 하루에요 *#님"]
                    var randomMessage = messages.randomElement()
                    randomMessage?.replace("*#", with: data.owner)
                    bubbleMessage.accept(randomMessage ?? "기분이 좋아요")
                }
                data.lv = checkingLv

                currentData.onNext(data)
                UserDefaults.standard.saveTamagochi(data)

                statusText.accept("LV\(data.lv) • 밥알 \(data.rice) • 물방울 \(data.water)")
                let lv = min(9,data.lv)
                let newImageString = "\(data.id)-\(lv)"
                imageName.accept(newImageString)
                titleText.accept("\(data.owner)님의 다마고치")
                nameText.accept(data.name)
            }
            .disposed(by: disposeBag)

        return Output(
            bubbleMessage: bubbleMessage,
            currentData: currentData,
            statusText: statusText,
            imageName: imageName,
            titleText: titleText,
            nameText: nameText
        )
    }
}
