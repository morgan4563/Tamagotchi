//
//  CustomObservable.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift

struct Lotto: Codable {
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

enum SampleError: Error {
    case sampleError
}

final class CustomObservable {
    static func getLotto(query: String) -> Observable<Lotto> {
        return Observable<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            print(url)
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(_):
                    observer.onError(SampleError.sampleError)
                }
            }
            return Disposables.create()
        }
    }
}
